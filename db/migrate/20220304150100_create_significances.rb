class CreateSignificances < ActiveRecord::Migration[6.1]
  def change
    create_table :significances do |t|
      t.string :sign_type

      t.timestamps
    end
  end
end
