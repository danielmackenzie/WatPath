class CreateJoinTabels < ActiveRecord::Migration
  def change
    create_table :courses_requirements do |t|
      t.integer :course_id
      t.integer :requirement_id
    end
    create_table :constraints_courses do |t|
      t.integer :course_id
      t.integer :constraint_id
    end
  end
end
