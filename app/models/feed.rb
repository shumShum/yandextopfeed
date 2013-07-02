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

  def self.return_by_time(time_option, page)
    time = DateTime.now - case time_option
      when 'all'
        2.year
      when 'hour'
        1.hour
      when '3hour'
        3.hour
      when 'day'
        1.day
      when 'week'
        1.week
      when '2week'
        2.week
      end
    feeds = Feed.paginate(page: page, per_page: 10)
      .where(published_at: time..Time.now)
      .order('published_at DESC')
  end

  def self.return_by_text(feeds, text)
    # out_feeds = []
    # feeds.each do |f|
    #   text.split(", ").each do |t|
    #     out_feeds.push(f) if f.title.index(t).present? || f.body.index(t).present?
    #   end
    # end
    # out_feeds.compact
    text.split(", ").each do |t|
      feeds = feeds.where('(title ILIKE ?) OR (body ILIKE ?)', "%#{t}%", "%#{t}%")
    end
    feeds
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
