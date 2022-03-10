class AddUserToDreamLabels < ActiveRecord::Migration[6.1]
  def change
    add_reference :dream_labels, :user, null: false, foreign_key: true
  end
end
