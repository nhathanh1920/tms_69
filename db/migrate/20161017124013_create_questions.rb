class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :answer_type
      t.text :content
      t.integer :status
      t.integer :level
      t.references :subject, index: true, foreign_key: true
      t.timestamps
    end
  end
end
