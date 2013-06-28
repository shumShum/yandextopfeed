class UpdateColumnToFeeds < ActiveRecord::Migration
  def change
  	change_column :feeds, :guid, :string
  end
end
