class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.string :short_form

      t.timestamps
    end
  end
end
