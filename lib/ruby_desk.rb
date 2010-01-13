require 'digest/md5'

class RubyDesk
  ODESK_API_URL = "www.odesk.com/api/"
  ODESK_AUTH_URL = "www.odesk.com/services/api/auth/"
  DEFAULT_OPTIONS = {:secure=>true, :sign=>true, :format=>'xml'}

  def initialize(api_key=nil, api_secret=nil)
    @api_key = api_key
    @api_secret = api_secret
  end

  # Sign the given parameters and updates the given
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
  def get_api_url(path, params = {}, options = {})
    options = DEFAULT_OPTIONS.merge(options)
    params[:api_sig] = sign(params) if options[:sign]
    {:url=>"http#{options[:secure]? 's' : ''}://" + ODESK_API_URL + path + "." + options[:format],
        :params=> params, :method=>options[:method]}
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
  def get_token_url(frob, options={})
    get_api_url 'auth/v1/keys/tokens', {:frob=>frob, :api_key=>@api_key}, options.merge(:method=>:post)
  end

  # Returns an authentication frob.
  #Parameters
  #    * api_key
  #    * api_sig
  #
  #Return Data
  #    * frob

  def get_frob_url(options={})
    get_api_url 'auth/v1/keys/frobs', {:api_key=>@api_key}, options.merge(:method=>:post)
  end

  #Returns the authenticated user associated with the given authorization token.
  #  Parameters
  #
  #      * api_key
  #      * api_sig
  #      * api_token
  #
  #  Return Data
  #
  #      * token
  def check_token_url(api_token, options={})
    get_api_url 'auth/v1/keys/token', {:api_key=>@api_key, :api_token=>@api_token}, options.merge(:method=>:get)
  end

  def revoke_token_url(api_token, options={})
    get_api_url 'auth/v1/keys/token', {:api_key=>@api_key, :api_token=>@api_token}, options.merge(:method=>:delete)
  end
end

