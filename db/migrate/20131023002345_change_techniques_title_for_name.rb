class ChangeTechniquesTitleForName < ActiveRecord::Migration
  def change
	rename_column :techniques, :title, :name
  end
end
