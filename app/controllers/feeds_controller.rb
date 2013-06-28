# encoding: utf-8
class FeedsController < ApplicationController 

	def index
		@feeds = Feed.paginate(page: params[:page], per_page: 10).order('published_at DESC')
	end

end