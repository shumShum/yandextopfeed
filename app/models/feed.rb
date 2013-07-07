# encoding: utf-8
require 'open-uri'
class Feed < ActiveRecord::Base
	YA_RSS_URL = 'http://news.yandex.ru/index.rss'

  attr_accessible :title, :body, :url, :published_at, :guid, :is_checked

  validates :title, presence: true
  validates :body, presence: true
  validates :url, presence: true

  def self.put_feeds
  	# feed = Feedzirra::Feed.fetch_and_parse(YA_RSS_URL)
  	# add_entries(feed.entries)
    page = Nokogiri::HTML(open("http://yandex.ru").read).xpath("//div[@class = 'b-news']")[0]
    lists = page.xpath("//ul[@class = 'b-news-list']")
    parse_list(lists[0], 'Новости')
    parse_list(lists[1], 'В Москве')
    parse_list(lists[2], 'В блогах')
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
      if Rails.env.production?
        feeds = feeds.where('(title ILIKE ?) OR (body ILIKE ?)', "%#{t}%", "%#{t}%")
      else
        feeds = feeds.where('(title LIKE ?) OR (body LIKE ?)', "%#{t}%", "%#{t}%")
      end
    end
    feeds
  end

  private

  def self.parse_list(list, i)
    list.element_children.each do |li|
      url = li.css('a')[0]['href']
      unless exists? url: url
        create!(
          title: i,
          body: li.content.insert(2, ' '),
          url: url,
          published_at: Time.now)
      end
    end
  end
  
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
