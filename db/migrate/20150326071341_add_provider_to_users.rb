class AddProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :integer, default: 0
  end
end
