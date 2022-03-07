class CreateDreamLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :dream_labels do |t|

      t.timestamps
    end
  end
end
