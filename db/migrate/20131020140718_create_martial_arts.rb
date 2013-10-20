class CreateMartialArts < ActiveRecord::Migration
  def change
    create_table :martial_arts do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
