class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :question_number
      t.integer :hard
      t.integer :medium
      t.integer :easy
      t.integer :duration

      t.timestamps
    end
  end
end
