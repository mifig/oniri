class CreateDreamsAndLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :dreams do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :significance, null: false, foreign_key: true
      t.datetime :dream_date, default: Time.now

      t.timestamps
    end

    create_table :labels do |t|
      t.string :title

      t.timestamps
    end

    create_table :dreams_labels, id: false do |t|
      t.belongs_to :dream
      t.belongs_to :label
    end
  end
end