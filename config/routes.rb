Yandextopfeed::Application.routes.draw do

  resources :feeds, {only: :index} do 
  	collection {
  		get :out_by_time
  		get :put_feeds
  	}
  end
  get '/out_by_time' => 'feeds#out_by_time'
  root to: 'feeds#index'

end
