require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    card = doc.css(".student-card")
    scraped_students = []
    card.each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
        }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = []
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    details = doc.css(".vitals-container")
    links = details.css(".social-icon-container a")
    links.each do |link|
      if link.attributes["href"].value.include?("twitter")
        scraped_student[:twitter] = link.attributes["href"].value
      elsif link.attributes["href"].value.include?("linkedin")
        scraped_student[:linkedin] = link.attributes["href"].value
      elsif link.attributes["href"].value.include?("github")
        scraped_student[:github] = link.attributes["href"].value
      else
        scraped_student[:blog] = link.attributes["href"].value
      end
    end
    scraped_student[:profile_quote] = details.css("div.profile-quote").text
    scraped_student[:bio] = doc.css("div.details-container div.bio-block div.bio-content div.description-holder p").text
    scraped_student
  end
end
