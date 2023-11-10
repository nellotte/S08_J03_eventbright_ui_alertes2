class AddValidationToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :validated, :boolean, default: nil
  end
end
