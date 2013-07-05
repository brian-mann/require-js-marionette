Rjs::Application.routes.draw do
	
	resources :dashboard, :only => [:index]
	resources :insights, :only => [:show]
	
	namespace :analytics do
		resources :customers, 	:only => [:index]
		resources :folders, 		:only => [:index]
		resources :foldertypes,	:only => [:index]
		resources :items,				:only => [:index]
		resources :activity,		:only => [:index]
		resources :locations,		:only => [:index]
		resources :points,			:only => [:index]
	end
	
	resources :schedule, :only => [:index]
	resources :subscriptions, :only => [:index, :create, :destroy, :update]

	resources :help do
	  collection do
  	  get 'privacy', :action => :privacy, :as => :privacy
  	  get 'subscription', :action => :subscription, :as => :subscription
    end
  end
	resource	:profile, :controller => :users, :only => [:show, :update]
	resources :images
	resources :billings
	resources :conditiontemplates
	resources :analytics do
    # get 'show_image', :action => "show_image", :as => :icon
		get 'companies', :action => :companies, :on => :collection
		get 'folders', :action => :folders, :on => :collection
	end
	resources :planning, :only => [:index, :show]
	resources :foldertypes
	resources :folders do
		get 'search', :on => :collection, :action => :index, :defaults => { :search => true }
		get 'report'
		get 'download'
		resources :pointfiles, :only => [:show]
		#resources :eventpoints, :only => [:update]
		#resources :eventpointfiles, :only => [:show, :destroy]
		resources :dispatches, :only => [:update, :create, :destroy]
		resources :itemevents, :only => [:index]
	end
	resources :dispatches, :only => [:create]
	resources :eventpoints, :only => [] do ## dont expose eventpoint routes since these require being nested
		resources :eventpointfiles, :only => [:destroy, :create, :update]
		resources :eventpointsketches, :only => [:index]
		resources :conditions, :only => [:index]
		resources :point_uoms, :only => [:index]
	end
	resources :eventpointfiles, :only => [:index]
	resources :itemevents do
		get 'report'
		get 'download'
		resources :eventpoints, :only => [:index, :update]
	end
	resources :foldertypecategories do
		resources :foldertypes
	end
	resources :conditionpriorities, :only => [:index]
	resources :jobtypes
	resources :productivity, :only => [:index, :show]
	resources :company
	resources :customers do
		get 'search', :on => :collection, :action => :index, :defaults => { :search => true }
		get '#:customer_id', :action => :index, :on => :collection, :as => :your_account
		get 'edit/assign_users', :action => :index, :as => :edit_users
		get "risks" => "itemevents#index", :defaults => { :type => "unresolved_priority_points" }
		#resources :eventpoints, :only => [:index]
		resources :itemevents, :only => [:index, :show, :update, :create, :destroy]
		resources :locations do
			resources :areas
		end
		resources :contacts
		resources :activity, :only => [:index]
	end
	resources :items, :only => [:index, :update, :show, :create, :destroy] do
		get 'search', :on => :collection, :action => :index, :defaults => { :search => true }
		get 'report' ## this is correct, do not want to have to tunnel through customers to fetch the item report
		resources :itemfiles, :only => [:show]
		resources :itemimages, :only => [:index]
		resources :itemevents, :only => [:index]
	end
	resources :masquerade, :only => [:show]
	resources :users
	namespace :admin do
	  resources :users, :only => [:index]
		resources :resources, :only => [:index]
		resources :logs, :only => [:index]
		resources :syncs, :only => [:index]
		resources :failed_authentications, :only => [:index]
  end
	resources :roles, :only => [:index]
	
	resources :teams do
		resources :users, :only => [:index]
		resources :customers, :only => [:index]
	end

	resources :locations do
		get 'page/:page', :action => :index, :on => :collection
	end

	resources :accounts do
	  resource :logo, :only => [:show, :create, :destroy]
  end

	resources :references, :only => [:index] ## used by customer new to grab the references active on the account

	resources :classtypes, :only => [:index] ## used for asset searching to return a list of just classtypes

	resources :categories do
		put "reorder", on: :collection
		resources :classtypes do
			put "reorder", on: :collection
		end
	end	

	resources :eventtypes, :only => [:show, :create, :update, :index, :destroy] do
		resources :pointcategories
		post "clone", on: :collection
	end
	
	resources :pointcategories, :only => [] do
		put "reorder", on: :collection
		
		resources :points do
			put "reorder", on: :collection
			post "clone", on: :collection
		end
	end
	
	resources :points, :only => [] do
		resources :regulations
		resources :pointfiles, :only => [:create, :destroy]
	end
	
	resources :inputtypes, :only => [:index]
	resources :datatypes, :only => [:index]
	resources :reports, :only => [:index, :create, :show] do
		get 'download'
	end
	resources :reportformats, :only => [:index]
	
	resources :regulations, :only => [:index]
	resources :itemstatuses do
		put "reorder", on: :collection
	end
	
	resources :classtypes, :only => [:show_image] do
		resources :pointcategories
		resources :classattributes do
			resources :attributeoptions
			resources :attributeuoms
		end		
		resources :points do
			#resources :regulations
			resources :pointprocedures
			resources :pointcannedcomments
		end
	end

	resources :events

	resources :sessions, :only => [:new, :create, :destroy]
	resources :password_resets, :only => [:index, :create, :edit, :update]

	
	
	match '/old_browser', :to => 'sessions#old_browser'
	match '/login', :to => 'sessions#new'
	#match '/login_after_password_update' => redirect { |p, req| req.flash[:info] = "Please log back in after your password has changed."; req.flash.keep; "/login" }
	match '/logout', :to => 'sessions#destroy'

	match '/admin', :to => redirect('/accounts'), :as => :admin

  match "facebook" => redirect('http://www.facebook.com/inspectall')
  match "twitter" => redirect('http://twitter.com/inspectall')
  match "linkedin" => redirect('http://www.linkedin.com/company/inspectall')
  match "gplus" => redirect('https://plus.google.com/116551035392284508960?prsrc=3')

	post "pusher/auth", to: "pusher#auth"
  
  get '/dashboards', :to => redirect('/')

	root :to => "application#index"

end