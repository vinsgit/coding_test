class CreateOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :otps do |t|
      t.string :code
      t.string :sid, limit: 50
      t.string :phone_number
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
