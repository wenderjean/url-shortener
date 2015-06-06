class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :origin
      t.string :shorted
      t.references :user, index: true

      t.timestamps
    end
  end
end
