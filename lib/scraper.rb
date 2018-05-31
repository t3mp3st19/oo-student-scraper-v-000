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
  		:profile_url => students.css(".student-card a").value }
		    student << student_hash
    end
    student
  end

  def self.scrape_profile_page(profile_url)
    doc = File.read("./fixtures/student-site/students/")
    student_profiles = Nokogiri::HTML(doc)

    student_profiles.css(".title-holder").text
  end

end
