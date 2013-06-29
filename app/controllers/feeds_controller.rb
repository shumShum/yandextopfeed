# encoding: utf-8
class FeedsController < ApplicationController 

	def index
		@feeds = Feed.paginate(page: params[:page], per_page: 10).order('published_at DESC')
	end

	def out_by_time
		@feeds = Feed.return_by_time(params[:time_option], params[:page])
		respond_to do |format|
      format.html { redirect_to root_url(page: params[:page]) }
      format.js
    end
	end

	def put_feeds
		Feed.put_feeds
		@feeds = Feed.return_by_time(params[:time_option], params[:page])
		respond_to do |format|
      format.html { redirect_to root_url(page: params[:page]) }
      format.js
    end
	end

end