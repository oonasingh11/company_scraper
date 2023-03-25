require 'open-uri'
require 'nokogiri'

class CeoController < ApplicationController
  def index
    url = 'https://www.example.com/about'
    doc = Nokogiri::HTML(open(url))

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
