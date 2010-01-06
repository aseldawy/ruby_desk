require 'digest/md5'
require 'uri'
require 'net/http'
require 'net/https'

module RubyDesk
  class Connector
    ODESK_API_URL = "www.odesk.com/api/"
    ODESK_AUTH_URL = "www.odesk.com/services/api/auth/"
    DEFAULT_OPTIONS = {:secure=>true, :sign=>true, :format=>'xml'}
    
    attr_writer :frob
    
    def initialize(api_key=nil, api_secret=nil, frob=nil, api_token=nil)
      @api_key = api_key
      @api_secret = api_secret
      @frob = frob
      @api_token = api_token
      @api_key = "991ac77f4c202873b0ab88f11762370c"
      @api_secret = "c3382d5902e5a7b0"
    end
    
    # Sign the given parameters and returns the signature 
    def sign(params)
      # sort parameters by its names (keys)
      sorted_params = params.sort { |a, b| a.to_s <=> b.to_s}
      
      # concatenate secret with names, values
      concatenated = @api_secret + sorted_params.to_s
      
      # Calculate md5 of concatenated string
      md5 = Digest::MD5.hexdigest(concatenated)
      
      # Return the calculated value as the signature
      md5
    end
    
    # Returns the correct URL to go to to invoke the given api
    # path: the path of the API to call. e.g. 'auth'
    # params: a hash of parameters that needs to be appended
    # options:
    # * :secure=>false: Whether a secure connection is required or not.
    # * :sign=>true: Whether you need to sign the parameters or not
    def prepare_api_call(path, params = {}, options = {})
      options = DEFAULT_OPTIONS.merge(options)
      params[:api_sig] = sign(params) if options[:sign]
      {:url=>"http#{options[:secure]? 's' : ''}://" + ODESK_API_URL + path + "." + options[:format],
          :params=> params, :method=>options[:method]}
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
    def prepare_and_invoke_api_call(path, params = {}, options = {})
      api_call = prepare_api_call(path, params, options)
      invoke_api_call(api_call)
    end
    
    # Returns the URL that authenticates the application for the current user
    def auth_url
      params = {:api_key=>@api_key}
      params[:api_sig] = sign(params)
      "https://"+ODESK_AUTH_URL+"?"+params.to_a.map{|pair| pair.join '='}.join('&')
    end
    
    # return the URL that logs user out of odesk applications
    def logout_url
      "https://"+ODESK_AUTH_URL
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
      response = prepare_and_invoke_api_call 'auth/v1/keys/tokens', {:frob=>@frob, :api_key=>@api_key}, :method=>:post, :format=>'json'
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
      response = prepare_and_invoke_api_call 'auth/v1/keys/frobs', {:api_key=>@api_key}, :method=>:post, :format=>'json'
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
      prepare_and_invoke_api_call 'auth/v1/keys/token', {:api_key=>@api_key, :api_token=>@api_token}, :method=>:get, :format=>'json'
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
      prepare_and_invoke_api_call 'auth/v1/keys/token', {:api_key=>@api_key, :api_token=>@api_token}, :method=>:delete, :format=>'json'
      @api_token = nil
    end
  
  end
end
