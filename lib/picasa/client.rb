require 'oauth'
require 'oauth/request_proxy/typhoeus_request'
module Picasa
  class Client
    BASE_URL = 'https://picasaweb.google.com/data'
    
    def initialize(api_key, api_secret, oauth_token, oauth_secret = nil)
      @consumer = ::OAuth::Consumer.new(api_key,api_secret, :site => BASE_URL)
      @token = ::OAuth::Token.new(oauth_token, oauth_secret)
      @oauth_params = {:consumer => @consumer, :token => @token}
      @client = ::Typhoeus::Hydra.new
    end
    
    def call(uri)
      request = ::Typhoeus::Request.new(BASE_URL + uri)
      oauth_helper = ::OAuth::Client::Helper.new(
        request, @oauth_params.merge(:request_uri => BASE_URL + uri)
      )
      request.headers.merge!({"Authorization" => oauth_helper.header})
      @client.queue(request)
      @client.run
      response = request.response
    end
  end
end