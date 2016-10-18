class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :chatwork_id
      t.string :password_digest
      t.string :remember_digest
      t.integer :role
      t.string :avatar

      t.timestamps
    end
  end
end
