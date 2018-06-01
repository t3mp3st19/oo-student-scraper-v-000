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
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    student = {}
    scrape_profile_page = {
      :profile_quote => doc.css(".vitals-text-container").text,
      :bio => doc.css(".description-holder p").text
    }

    doc.css(".social-icon-container a").each do |link| #match iterates over regex for the literal words for social media
      student[:github] = link["a"] if /github/.match(link['href'])
      student[:twitter] = link["a"] if /twitter/.match(link['href'])
      student[:linkedin] = link["a"] if /linkedin/.match(link['href'])
      student[:blog] = link["a"] if !/(github|linkedin|twitter)/.match(link['href'])
    end
    scrape_profile_page
    student
  end

end
