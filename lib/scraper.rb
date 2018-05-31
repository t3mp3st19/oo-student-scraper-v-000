require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = File.read("./fixtures/student-site/index.html")
    students = Nokogiri::HTML(doc)
    binding.pry
    #return value is hash of each student, :name, :location, :profile_url   students = {}
    students.css(".student-card").text
		name = students.css(".student-name").text
		location = students.css(".student-location").text
		url["href"] = students.css(".student-card a")
    #url["href"]
    #student
  end

  def self.scrape_profile_page(profile_url)
    doc = File.read("./fixtures/student-site/students/")
    student_profiles = Nokogiri::HTML(doc)

    student_profiles.css(".title-holder").text
  end

end
