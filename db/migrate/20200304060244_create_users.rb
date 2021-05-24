class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.integer :role, null: false, default: 0
      t.index :email, unique: true
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
