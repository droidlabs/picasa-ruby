require 'oauth'
require 'oauth/request_proxy/typhoeus_request'
require 'xmlsimple'
module Picasa
  class Client
    BASE_URL = 'https://picasaweb.google.com/data'
    
    def initialize(api_key = nil, api_secret = nil, token = nil, secret = nil)
      @api_key, @api_secret = api_key, api_secret
      @client = ::Typhoeus::Hydra.new
      # if api call protected, create token and consumer
      if protected_api_call?
        @consumer = ::OAuth::Consumer.new(api_key,api_secret, :site => BASE_URL)
        @token = ::OAuth::Token.new(token, secret)
      end
    end
    
    def call(uri)
      request = ::Typhoeus::Request.new(BASE_URL + uri)
      authorize_request!(request) if protected_api_call?
      @client.queue(request)
      @client.run
      XmlSimple.xml_in(request.response.body)
    end
    
    def albums(user)
      xml = call("/feed/api/user/#{user}")
      albums = []
      xml['entry'].each do |entry|
        album = Picasa::Album.new
        album.id = entry['id'][1]
        album.title = entry['title'][0]['content']
        album.summary = entry['summary'][0]['content']
        album.size = entry['numphotos'][0].to_i
        album.image = entry['group'][0]['content']['url']
        album.thumbnail = entry['group'][0]['thumbnail'][0]['url']
        albums << album
      end if xml['entry']
      albums
    end
    
    def photos(user, album_id)
      xml = call("/feed/api/user/#{user}/albumid/#{album_id}")
      photos = []
      xml['entry'].each do |entry|
        photo = Picasa::Photo.new
        photo.title = entry['group'][0]['description'][0]['content']
        photo.thumbnails = [
          entry['group'][0]['thumbnail'][0]['url'],
          entry['group'][0]['thumbnail'][1]['url'],
          entry['group'][0]['thumbnail'][2]['url']
        ]
        photo.image = entry['content']['src']
        photos << photo
      end if xml['entry']
      photos
    end
    
    protected
    def protected_api_call?
      !@api_key.nil?
    end
    
    def authorize_request!(request)
      oauth_helper = ::OAuth::Client::Helper.new(
        request, {
          :consumer => @consumer, 
          :token => @token,
          :request_uri => request.url
        }
      )
      request.headers.merge!({"Authorization" => oauth_helper.header})
    end
  end
end