class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :short_form
      t.text :title
      t.text :description
      t.string :terms_offered
      t.string :course_type
      t.float :required_grade

      t.timestamps
    end
  end
end
