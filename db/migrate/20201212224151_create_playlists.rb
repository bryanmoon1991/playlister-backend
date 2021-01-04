class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.boolean :public
      t.boolean :collaborative
      t.boolean :published
      t.string :description
      t.string :href
      t.string :spotify_id
      t.jsonb :history
      t.jsonb :images
      t.jsonb :items
      t.string :uri

      t.timestamps
    end
  end
end
