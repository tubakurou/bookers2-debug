class ChangeDataUserIdToFavorites < ActiveRecord::Migration[5.2]
  def change
     change_column :favorites, :user_id, :integer
  end
end
