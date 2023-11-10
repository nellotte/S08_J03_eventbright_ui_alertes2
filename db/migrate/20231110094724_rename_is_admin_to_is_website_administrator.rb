class RenameIsAdminToIsWebsiteAdministrator < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :is_admin, :is_website_administrator
  end
end
