class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :phone_number
      t.string :otp
      t.string :email
      t.date :available_on
      t.integer :role

      t.timestamps
    end
  end
end
