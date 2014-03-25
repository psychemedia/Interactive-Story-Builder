BootstrapStarter::Application.routes.draw do
  

	#--------------------------------
	# all resources should be within the scope block below
	#--------------------------------
	scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

		match '/admin', :to => 'admin#index', :as => :admin, :via => :get
		devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}

		namespace :admin do
			resources :users
		end

		resources :stories do				
			member do

				get 'get_data'

				put 'content', to: 'stories#save_content'
				post 'content', to: 'stories#new_content'

				delete 'tree', to: 'stories#destroy_tree_item'

				put 'media', to: 'stories#save_media'
				post 'media', to: 'stories#new_media'				

				put 'section', to: 'stories#save_section'
				post 'section', to: 'stories#new_section'				

    			get 'sections'    			    			    			    	    			
  			end			
		end

		match "storyteller/:id" => "storyteller#index", as: 'storyteller_show'


		root :to => 'root#index'
	  match "*path", :to => redirect("/#{I18n.default_locale}") # handles /en/fake/path/whatever
	end

	match '', :to => redirect("/#{I18n.default_locale}") # handles /
	match '*path', :to => redirect("/#{I18n.default_locale}/%{path}") # handles /not-a-locale/anything

end
