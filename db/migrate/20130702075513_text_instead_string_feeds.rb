class TextInsteadStringFeeds < ActiveRecord::Migration
  def change
  	change_column :feeds, :body, :text, :limit => nil 
  end
end
