require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = File.read("./fixtures/student-site/index.html")
    students = Nokogiri::HTML(doc)
    #binding.pry
    #return value is hash of each student, :name, :location, :profile_url   students = {}
    students.css(".student-card").each do |card|
		#students = {}
		#student = Student.new
		students.name = card.css(".student-name").text
		students.location = card.css(".student-location").text
		students.url = card.css("a").text

 end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
