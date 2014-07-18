class CourseController < ApplicationController
  def next_courses
    selected_courses = params[:selected_courses].split(',')
    selected_department = params[:selected_department]
    new_courses = Array.new
    unavailable_courses = Array.new

    selected_courses.each do |course_code|
      course = Course.where(:short_form => course_code.strip).first
      course.constraints.where(:pre_requisite => true).each do |constraint|
        other_courses = constraint.courses

        if other_courses[0].short_form != course_code.strip
          new_courses << other_courses[0]
        end
      end

      course.constraints.where(:anti_requisite => true).each do |constraint|
        other_courses = constraint.courses

        if other_courses[0].short_form != course_code.strip
          unavailable_courses << other_courses[0]
        end
      end
    end

    respond_to do |format|
      format.json { render json: { :next_courses => new_courses, :unavailable_courses => unavailable_courses } }
    end
  end
end
