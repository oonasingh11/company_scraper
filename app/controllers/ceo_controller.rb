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

    ceo_name = doc.at_css('div.ceo-name').text
    ceo_email = doc.at_css('div.ceo-email').text
    ceo_phone = doc.at_css('div.ceo-phone').text

    @ceo_info = {
      name: ceo_name,
      email: ceo_email,
      phone: ceo_phone
    }
  end
end
