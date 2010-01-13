require 'digest/md5'
require 'uri'
require 'net/http'
require 'net/https'

module RubyDesk
  class Connector
    ODESK_URL = "www.odesk.com/"
    ODESK_API_URL = "#{ODESK_URL}api/"
    ODESK_GDS_URL = "#{ODESK_URL}gds/"
    ODESK_AUTH_URL = "#{ODESK_URL}services/api/auth/"
    DEFAULT_OPTIONS = {:secure=>true, :sign=>true, :format=>'json',
      :base_url=>ODESK_API_URL, :auth=>true}

    attr_writer :frob

    def initialize(api_key=nil, api_secret=nil, api_token=nil)
      @api_key = api_key
      @api_secret = api_secret
      @api_token = api_token
    end

    # Sign the given parameters and returns the signature
    def sign(params)
      # sort parameters by its names (keys)
      sorted_params = params.sort { |a, b| a.to_s <=> b.to_s}

      # concatenate secret with names, values
      concatenated = @api_secret + sorted_params.to_s

      # Calculate and return md5 of concatenated string
      Digest::MD5.hexdigest(concatenated)
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
      params[:api_sig] = sign(params) if options[:sign] || options[:auth]
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

      data = api_call[:params].to_a.map{|pair| pair.join '='}.join('&')
      headers = {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }

      case api_call[:method]
        when :get, 'get' then
          resp, data = http.request(Net::HTTP::Get.new(url.path+"?"+data, headers))
        when :post, 'post' then
          resp, data = http.request(Net::HTTP::Post.new(url.path, headers), data)
        when :delete, 'delete' then
          resp, data = http.request(Net::HTTP::Delete.new(url.path, headers), data)
      end

      return data
    end

    # Prepares an API call with the given arguments then invokes it and returns its body
    def prepare_and_invoke_api_call(path, options = {})
      api_call = prepare_api_call(path, options)
      invoke_api_call(api_call)
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
        :secure=>false)
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
      response = prepare_and_invoke_api_call 'auth/v1/keys/tokens',
          :params=>{:frob=>@frob, :api_key=>@api_key}, :method=>:post,
          :auth=>false
      json = JSON.parse(response)
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
      response = prepare_and_invoke_api_call 'auth/v1/keys/frobs',
        :params=>{:api_key=>@api_key}, :method=>:post, :auth=>false
      json = JSON.parse(response)
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
      prepare_and_invoke_api_call 'auth/v1/keys/token', :method=>:get
      json = JSON.parse(response)
      # TODO what to make with results?
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

