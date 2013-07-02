class AddIsCheckedToFeeds < ActiveRecord::Migration
  def change
  	add_column :feeds, :is_checked, :boolean, default: false
  end
end
