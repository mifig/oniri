class AddUserToLabels < ActiveRecord::Migration[6.1]
  def change
    add_reference :labels, :user, null: false, foreign_key: true
  end
end
