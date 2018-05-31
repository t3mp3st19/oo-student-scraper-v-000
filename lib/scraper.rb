require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student = []
    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    card = doc.css(".student-card")
    #binding.pry
    #return value is hash of each student, :name, :location, :profile_url   students = {}
    card.each do |students|
      student_hash = { :name => students.css(".student-name").text,
  		:location => students.css(".student-location").text,
  		:profile_url => students.css(".student-card a").text }
		    student << student_hash
    end
    student
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    scrape_profile_page = {
      :profile_quote => doc.css(".vitals-text-container").text,
      :bio => doc.css(".description-holder p").text
    }

    social_media = doc.css(".social-icon-container a")

    social_media.each do |social|
      if social_media.attribute("href").text.include?("twitter")
        scrape_profile_page[:twitter] = social.attribute("href").text
      elsif social_media.attribute("href").text.include?("github")
        scrape_profile_page[:github] = social.attribute("href").text
      elsif social_media.attribute("href").text.include?("linkedin")
        scrape_profile_page[:linkedin] = social.attribute("href").text
      else
        scrape_profile_page[:blog] = social.attribute("href").text
    end
  end
    scrape_profile_page
  end

end
