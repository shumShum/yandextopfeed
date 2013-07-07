task :put_feeds => :environment do
  puts "Updating feed..."
  Feed.put_feeds
  puts "done."
end

task :destroy_feeds => :environment do
	puts "Destroy feed..."
  Feed.where('published_at < ?', Time.now - 2.week).destroy_all
  puts "done."
end