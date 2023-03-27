require 'uri'
require 'net/http'
require 'nokogiri'

class CeoController < ApplicationController
  def index
    url = URI.parse('https://www.example.com/about')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true if url.scheme == 'https'

    request = Net::HTTP::Get.new(url.request_uri)
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
