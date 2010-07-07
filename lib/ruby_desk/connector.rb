require 'digest/md5'
require 'uri'
require 'net/http'
require 'net/https'
require 'rexml/document'
require 'json'

module RubyDesk
  # Basic methods used for connecting with oDesk like signing request parameters and parsing response.
  # This class is also responsible for authorizing user
  class Connector
    ODESK_URL = "www.odesk.com/"
    ODESK_API_URL = "#{ODESK_URL}api/"
    ODESK_GDS_URL = "#{ODESK_URL}gds/"
    ODESK_AUTH_URL = "#{ODESK_URL}services/api/auth/"
    DEFAULT_OPTIONS = {:secure=>true, :sign=>true, :format=>'json',
      :base_url=>ODESK_API_URL, :auth=>true}

    attr_writer :frob
    attr_accessor :auth_user

    def initialize(api_key=nil, api_secret=nil, api_token=nil)
      @api_key = api_key
      @api_secret = api_secret
      @api_token = api_token
    end

    # Sign the given parameters and returns the signature
    def sign(params)
      RubyDesk.logger.debug {"Params to sign: #{params.inspect}"}
      # sort parameters by its names (keys)
      sorted_params = params.sort { |a, b| a.to_s <=> b.to_s}

      RubyDesk.logger.debug {"Sorted params: #{sorted_params.inspect}"}
      
      # Unescape escaped params
      sorted_params.map! do |k, v|
        [k, URI.unescape(v)]
      end

      # concatenate secret with names, values
      concatenated = @api_secret + sorted_params.to_s

      RubyDesk.logger.debug {"concatenated: #{concatenated}"}

      # Calculate and return md5 of concatenated string
      md5 = Digest::MD5.hexdigest(concatenated)

      RubyDesk.logger.debug {"md5: #{md5}"}

      return md5
    end

    # Returns the correct URL to go to to invoke the given api
    # path: the path of the API to call. e.g. 'auth'
    # options:
    # * :secure=>false: Whether a secure connection is required or not.
    # * :sign=>true: Whether you need to sign the parameters or not
    # * :params=>{}: a hash of parameters that needs to be appended
    # * :auth=>true: when true indicates that this call need authentication.
    #     This forces adding :api_token, :api_key and :api_sig to parameters.
    def prepare_api_call(path, options = {})
      options = DEFAULT_OPTIONS.merge(options)
      params = options[:params] || {}
      if options[:auth]
        params[:api_token] ||= @api_token
        params[:api_key] ||= @api_key
      end
      params[:api_sig] = sign(params) if options[:secure] && (options[:sign] || options[:auth])
      url = (options[:secure] ? "https" : "http") + "://"
      url << options[:base_url] << path
      url << ".#{options[:format]}" if options[:format]
      return {:url=>url, :params=> params, :method=>options[:method]}
    end

    # invokes the given API call and returns body of the response as text
    def invoke_api_call(api_call)
      url = URI.parse(api_call[:url])
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      # Concatenate parameters to form data
      data = api_call[:params].to_a.map{|pair| pair.map{|x| URI.escape(x.to_s)}.join '='}.join('&')
      headers = {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }

      RubyDesk.logger.info "URL: #{api_call[:url]}"
      RubyDesk.logger.info "method: #{api_call[:method]}"
      RubyDesk.logger.info "Params: #{data}"

      case api_call[:method]
        when :get, 'get' then
          resp, data = http.request(Net::HTTP::Get.new(url.path+"?"+data, headers))
        when :post, 'post' then
          resp, data = http.request(Net::HTTP::Post.new(url.path, headers), data)
        when :delete, 'delete' then
          resp, data = http.request(Net::HTTP::Delete.new(url.path, headers), data)
      end

      RubyDesk.logger.info "Response code: #{resp.code}"
      RubyDesk.logger.info "Returned data: #{data}"

      case resp.code
        when "200" then return data
        when "400" then raise RubyDesk::BadRequest, data
        when "401", "403" then raise RubyDesk::UnauthorizedError, data
        when "404" then raise RubyDesk::PageNotFound, data
        when "500" then raise RubyDesk::ServerError, data
        else raise RubyDesk::Error, data
      end

    end

    # Prepares an API call with the given arguments then invokes it and returns its body
    def prepare_and_invoke_api_call(path, options = {})
      api_call = prepare_api_call(path, options)
      data = invoke_api_call(api_call)

      parsed_data = case options[:format]
        when 'json' then JSON.parse(data)
        when 'xml' then REXML::Document.new(data)
        else JSON.parse(data) rescue REXML::Document.new(data) rescue data
      end
      RubyDesk.logger.info "Parsed data: #{parsed_data.inspect}"
      return parsed_data
    end

    # Returns the URL that authenticates the application for the current user
    def auth_url
      auth_call = prepare_api_call("", :params=>{:api_key=>@api_key},
        :base_url=>ODESK_AUTH_URL, :format=>nil, :method=>:get, :auth=>false)
      data = auth_call[:params].to_a.map{|pair| pair.join '='}.join('&')
      return auth_call[:url]+"?"+data
    end

    # return the URL that logs user out of odesk applications
    def logout_url
      logout_call = prepare_api_call("", :base_url=>ODESK_AUTH_URL,
        :secure=>false, :auth=>false, :format=>nil)
      return logout_call[:url]
    end

    # Returns an authentication frob.
    #  Parameters
    #    * frob
    #    * api_key
    #    * api_sig
    #
    #  Return Data
    #    * token
    def get_token
      json = prepare_and_invoke_api_call 'auth/v1/keys/tokens',
          :params=>{:frob=>@frob, :api_key=>@api_key}, :method=>:post,
          :auth=>false
      @auth_user = User.new(json['auth_user'])
      @api_token = json['token']
    end

    # Returns an authentication frob.
    #Parameters
    #    * api_key
    #    * api_sig
    #
    #Return Data
    #    * frob

    def get_frob
      json = prepare_and_invoke_api_call 'auth/v1/keys/frobs',
        :params=>{:api_key=>@api_key}, :method=>:post, :auth=>false
      @frob = json['frob']
    end

    # Returns the authenticated user associated with the given authorization token.
    #  Parameters
    #
    #      * api_key
    #      * api_sig
    #      * api_token
    #
    #  Return Data
    #
    #      * token
    def check_token
      json = prepare_and_invoke_api_call 'auth/v1/keys/token', :method=>:get
      # TODO what to do with results?
      return json
    end

    # Revokes the given aut
    # Parameters
    #  * api_key
    #  * api_sig
    #  * api_token

    def revoke_token
      prepare_and_invoke_api_call 'auth/v1/keys/token', :method=>:delete
      @api_token = nil
    end

  end
end

