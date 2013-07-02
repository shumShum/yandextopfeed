# encoding: utf-8
class FeedsController < ApplicationController 

	def index
		@feeds = Feed.paginate(page: params[:page], per_page: 10).order('published_at DESC')
		@time_option = 'all'
		@check_option = false
	end

	def update
		@feed = Feed.find(params[:id])
		@feed.update_attributes(params[:feed])
		respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
	end

	def out_by_options
		@time_option = params[:time_option]
		@text_option = params[:text_option]
		@check_option = params[:check_option] == 'true' ? true : false
		@feeds = Feed.return_by_time(@time_option, params[:page])
		@feeds = Feed.return_by_text(@feeds, @text_option) if @text_option.present?
		@feeds = @feeds.where(is_checked: @check_option) if @check_option
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