class AddNotifyToFollowers < ActiveRecord::Migration
  def change
    add_column :followers, :notify, :boolean
  end
end
