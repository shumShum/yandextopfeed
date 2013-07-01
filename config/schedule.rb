every :hour do 
 	runner 'Feed.put_feeds'
end

every :month do
	runner 'Feed.destroy_all'
end
