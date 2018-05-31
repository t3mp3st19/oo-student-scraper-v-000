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
      student << {
        :name => students.css(".student-name").text,
  		  :location => students.css(".student-location").text,
  		  :profile_url => students.css(".student-card a").text }
    end
    student
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = []
    profile.css("div.social-icon-container a").select{|link| link['href']}.each do |link|
      student[:github] = link['href'] if /github/.match(link['href'])
      student[:twitter] = link['href'] if /twitter/.match(link['href'])
      student[:linkedin] = link['href'] if /linkedin/.match(link['href'])
      student[:blog] = link['href'] if !/(github|linkedin|twitter)/.match(link['href'])
    end
    student[:bio] = profile.css("div.description-holder p").text
    student[:profile_quote] = profile.css("div.profile-quote").text
    student
  end

end
