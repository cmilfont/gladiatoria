class CreateMartialArtsAndTechniques < ActiveRecord::Migration
  def change
    create_table :martial_arts_techniques do |t|
      t.integer :martial_art_id
      t.integer :technique_id
    end
  end
end
