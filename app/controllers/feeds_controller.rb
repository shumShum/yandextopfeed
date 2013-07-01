# encoding: utf-8
class FeedsController < ApplicationController 

	def index
		@feeds = Feed.paginate(page: params[:page], per_page: 10).order('published_at DESC')
		@time_option = 'all'
	end

	def out_by_time
		@time_option = params[:time_option]
		@feeds = Feed.return_by_time(@time_option, params[:page])
		respond_to do |format|
      format.html { redirect_to root_url(page: params[:page]) }
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

	def destroy
		Feed.find(params[:id]).destroy
		@time_option = params[:time_option]
		@feeds = Feed.return_by_time(@time_option, params[:page])
		respond_to do |format|
      format.html { redirect_to root_url(page: params[:page]) }
      format.js
    end
	end

end