class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.boolean :private
      t.string :description
      t.string :href
      t.string :spotify_id
      t.string :images, array: true, default: []
      t.string :items, array: true, default: []
      t.string :uri

      t.timestamps
    end
  end
end
