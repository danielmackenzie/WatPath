require 'open-uri'

class Course < ActiveRecord::Base
  has_and_belongs_to_many :requirements
  has_and_belongs_to_many :constraints

  def self.update_course_content
    document = Nokogiri::HTML.parse(open('http://www.adm.uwaterloo.ca/infocour/CIR/SA/under.html'))
    course_codes = Array.new
    latest_term = nil

    document.css('option').each do |tag|
      if tag.text.to_i > 0
        latest_term = tag.text.strip
      else
        course_codes << tag.text.strip
      end
    end

    course_codes.each do |course_type|
      course_type_document = Nokogiri::HTML.parse(open('http://www.adm.uwaterloo.ca/cgi-bin/cgiwrap/infocour/salook.pl?level=under&sess=' + latest_term + '&subject=' + course_type))

      course_tags = course_type_document.css('tr > td')
      course_tags.each_with_index do |course_tag, index|
        if course_tag.text.strip == course_type
          course_short_form = course_tag.text.strip + ' ' + course_tags[index + 1].text.strip
          puts course_short_form
          course_title = course_tags[index + 3].text.strip
          current_course = Course.where(:short_form => course_short_form).first

          if current_course == nil
            current_course = Course.new
            current_course.short_form = course_short_form
          end
          current_course.title = course_title
          current_course.save!
        end
      end
    end
  end
end
