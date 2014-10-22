class AddMarkedToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :marked, :boolean
  end
end
