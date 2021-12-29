class ChangeDataBookIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    change_column :favorites, :book_id, :integer
  end
end
