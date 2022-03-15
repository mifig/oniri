class AddImportanceToSignificances < ActiveRecord::Migration[6.1]
  def change
    add_column :significances, :importance, :string, default: ""
  end
end
