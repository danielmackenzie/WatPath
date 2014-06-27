class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :major_id
      t.integer :option_id
      t.string :name
      t.string :course_type
      t.integer :requirement_count

      t.timestamps
    end
  end
end
