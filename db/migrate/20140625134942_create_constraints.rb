class CreateConstraints < ActiveRecord::Migration
  def change
    create_table :constraints do |t|
      t.string :major_type
      t.string :term
      t.boolean :pre_requisite
      t.boolean :anti_requisite

      t.timestamps
    end
  end
end
