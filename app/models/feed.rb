class Feed < ActiveRecord::Base
	YA_RSS_URL = 'http://news.yandex.ru/index.rss'

  attr_accessible :title, :body, :url, :published_at, :guid

  validates :title, presence: true
  validates :body, presence: true
  validates :url, presence: true

  def self.put_feeds
  	feed = Feedzirra::Feed.fetch_and_parse(YA_RSS_URL)
  	add_entries(feed.entries)
  end

  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          title:        entry.title,
          body:      		entry.summary,
          url:          entry.url,
          published_at: entry.published,
          guid:         entry.id
        )
      end
    end
  end

end
