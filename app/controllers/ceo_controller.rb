require 'uri'
require 'net/http'
require 'nokogiri'

class CeoController < ApplicationController
  def index
    url = params[:url]
    if url.present?
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      doc = Nokogiri::HTML(response.body)

      ceo_name = doc.at_css('div.ceo-name')&.text || 'Unknown'
      ceo_email = doc.at_css('div.ceo-email')&.text || 'Unknown'
      ceo_phone = doc.at_css('div.ceo-phone')&.text || 'Unknown'

      @ceo_info = {
        name: ceo_name,
        email: ceo_email,
        phone: ceo_phone
      }

      @ceo = Ceo.new(name: ceo_name, email: ceo_email, phone: ceo_phone)
      @ceo.save
    end
  end
end
