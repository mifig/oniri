class AddColorToLabels < ActiveRecord::Migration[6.1]
  def change
    add_column :labels, :color, :string, default: "#51C4D3"
  end
end
