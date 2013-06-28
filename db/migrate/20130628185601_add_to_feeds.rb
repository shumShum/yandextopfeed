class AddToFeeds < ActiveRecord::Migration
  def change
  	add_column :feeds, :published_at, :datetime
  	add_column :feeds, :guid, :integer
  end
end
