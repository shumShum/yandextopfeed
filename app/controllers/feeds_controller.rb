# encoding: utf-8
class FeedsController < ApplicationController 

	def index
		@feeds = Feed.paginate(page: params[:page], per_page: 10).order('published_at DESC')
		@time_option = 'all'
	end

	def out_by_options
		@time_option = params[:time_option]
		@text_option = params[:text_option]
		@feeds = Feed.return_by_time(@time_option, params[:page])
		@feeds = Feed.return_by_text(@feeds, @text_option) if @text_option.present?
		respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
	end

	def put_feeds
		Feed.put_feeds
		@time_option = params[:time_option]
		@feeds = Feed.return_by_time(@time_option, params[:page])
		respond_to do |format|
      format.html { redirect_to root_url(page: params[:page]) }
      format.js
    end
	end

end