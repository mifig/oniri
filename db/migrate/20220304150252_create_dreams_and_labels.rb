class CreateDreamsAndLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :dreams do |t|
      t.string :title
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :significance, null: true, foreign_key: true
      t.datetime :dream_date, default: Time.now

      t.timestamps
    end

    create_table :labels do |t|
      t.string :title

      t.timestamps
    end

    create_table :dream_labels do |t|
      t.references :dream, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
    end
  end
end