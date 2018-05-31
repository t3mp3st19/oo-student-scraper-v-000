require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    roster = doc.css(".student-card")
      roster.each do |student|
        hash = {
         :name => student.css(".card-text-container .student-name").text,
         :location => student.css(".card-text-container .student-location").text,
         :profile_url => index_url + student.css("a").attribute("href").value,
       }
       scraped_students << hash
     end
     scraped_students
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
