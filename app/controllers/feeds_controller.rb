# encoding: utf-8
class FeedsController < ApplicationController 

	def index
		@feeds = Feed.paginate(page: params[:page], per_page: 10).order('published_at DESC')
	end

	def out_by_time
		time = DateTime.now - case params[:time_option]
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
		@feeds = Feed.paginate(page: params[:page], per_page: 10)
			.where(published_at: time..Time.now)
			.order('published_at DESC')
		respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
	end

end