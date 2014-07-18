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
    # ['CS'].each do |course_type|
      course_type_document = Nokogiri::HTML.parse(open('http://www.adm.uwaterloo.ca/cgi-bin/cgiwrap/infocour/salook.pl?level=under&sess=' + latest_term + '&subject=' + course_type))

      begin
        course_description_document = Nokogiri::HTML.parse(open('http://www.ucalendar.uwaterloo.ca/1415/COURSE/course-' + course_type.strip + '.html'))
      rescue
        puts 'Error: No descriptions found for ' + course_type.strip
      end

      course_tags = course_type_document.css('tr > td')
      course_tags.each_with_index do |course_tag, index|
        begin
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
          course_description_tags = course_description_document.css('tr > td')
          located_course = nil
          counter = 0

          course_description_tags.each_with_index do |description_tag, description_index|
            begin
              if description_tag.text.match(/#{course_short_form}/) && description_tag.text.match(/LEC/)
                puts description_tag.text + ' - ' + course_short_form
                located_course = true
                current_course.description = course_description_tags[description_index + 3].text

                description_tag.parent().parent().css('tr > td').each do |sub_section|
                  if sub_section.text.match(/Prereq:/)
                    prereq_entries = sub_section.text.split(' ')
                    processing = false

                    prereq_entries.each do |entry|
                      processed_entry = entry.strip.gsub(/[;,,,\.]/, '')
                      if processing && processed_entry.to_i >= 100 && processed_entry.to_i < 700
                        prereq_course = Course.where(:short_form => course_type.strip + ' ' + processed_entry).first
                        constraints = current_course.constraints.where(:pre_requisite => true)
                        found = false

                        constraints.each do |constraint|
                          if constraint.courses.include?(prereq_course)
                            found = true
                            break
                          end
                        end

                        if found == false && prereq_course
                          new_constraint = Constraint.new
                          new_constraint.pre_requisite = true
                          new_constraint.courses << current_course
                          new_constraint.courses << prereq_course
                          new_constraint.save
                        end
                        puts course_type.strip + ' ' + entry.strip.gsub(/[;,,,\.]/, '') + ' is a prereq for ' + course_short_form
                        next
                      end
                      if entry.strip == course_type.strip
                        processing = true
                        next
                      elsif course_codes.include?(entry.strip)
                        processing = false
                      end
                    end
                  elsif sub_section.text.match(/Antireq:/)
                    antireq_entries = sub_section.text.split(' ')
                    processing = false

                    antireq_entries.each do |entry|
                      processed_entry = entry.strip.gsub(/[;,,,\.]/, '')
                      if processing && processed_entry.to_i >= 100 && processed_entry.to_i < 700
                        antireq_course = Course.where(:short_form => course_type.strip + ' ' + processed_entry).first
                        constraints = current_course.constraints.where(:anti_requisite => true)
                        found = false

                        constraints.each do |constraint|
                          if constraint.courses.include?(antireq_course)
                            found = true
                            break
                          end
                        end

                        if found == false && antireq_course
                          new_constraint = Constraint.new
                          new_constraint.anti_requisite = true
                          new_constraint.courses << current_course
                          new_constraint.courses << antireq_course
                          new_constraint.save
                        end
                        puts course_type.strip + ' ' + entry.strip.gsub(/[;,,,\.]/, '') + ' is a antireq for ' + course_short_form
                        next
                      end
                      if entry.strip == course_type.strip
                        processing = true
                        next
                      elsif course_codes.include?(entry.strip)
                        processing = false
                      end
                    end
                  end
                end
              end
            rescue
              puts 'Cannot turn element into text'
            end

            if located_course
              counter += 1
            end
            if counter >= 8
              break
            end
          end

          current_course.save!
        end
        rescue
          puts 'Course type parse error'
        end
      end
    end
  end
end
