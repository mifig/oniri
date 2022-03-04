class CreateDreams < ActiveRecord::Migration[6.1]
  def change
    create_table :dreams do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :significance, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
      t.datetime :dream_date, default: Time.now

      t.timestamps
    end
  end
end
