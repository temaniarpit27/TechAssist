Rails.application.routes.draw do

  resources :users
  #resources :repositories
  get '/repositories/get_all' => 'repositories#get_all_repos'

  resources :questions do
    resources :votes
    resources :answers
    resources :comments
    resources :answers do
      resources :votes
      resources :comments
    end
  end

  post "logout" => "users#logout", as: "logout"

  resources :sections

  namespace :sections do
    namespace :sub_sections do
      resources :contents
    end
  end

  namespace :sections do
    resources :sub_sections
  end

  resources :products

  resources :csrm_profiles

  resources :rm_pocs

  root "banks#index"

  resources :employers

  resources :cities
  get "banks/get_all_banks" => "banks#get_all_banks"
  get "banks/get_bank/:id" => "banks#get_bank"

  resources :banks do
    post :reorder_bank_priorities, on: :collection
  end

  get "/products/:id/duplicate" => "products#duplicate", :as => 'duplicate_product'
  get "short_forms/new_lead" => 'short_forms#new_lead', :as => 'new_lead_short_form'
  post "short_forms/create_lead" => 'short_forms#create_lead', :as => 'create_new_lead'
  get "/short_forms/rm_panel" => 'short_forms#rm_panel', :as => 'rm_panel'
  get "/short_forms/csrm_panel" => 'short_forms#csrm_panel', :as => 'csrm_panel'
  get "/short_forms/:id/get_partial_edit_form" => 'short_forms#get_partial_edit_form', :as => 'get_partial_edit_form'
  get "/short_forms/:id/get_partial_show_form" => 'short_forms#get_partial_show_form', :as => 'get_partial_show_form'

  post "/short_forms/update_draft_application/:id" => 'short_forms#update_draft_application', :as => 'csrm_update_draft_application'
  post "/short_forms/clone_submitted_application/:id" => 'short_forms#clone_submitted_application', :as => 'csrm_clone_submitted_application'

  get "/short_forms/search_panel" => 'short_forms#search_panel', :as => 'search_panel'
  get "short_forms/modify_search_panel/" => 'short_forms#modify_search_panel', :as => 'modify_search_panel'
  get "/short_forms/user_predictions" => 'short_forms#user_predictions', :as => 'user_predictions'

  get   "short_forms/status/:status"  => 'short_forms#requests_by_status',  :as => 'short_forms_with_status'

  get   "short_forms/:id/schedule_callback_client"      => 'short_forms#schedule_callback_form_client',   :as => 'short_form_schedule_callback_client'
  patch "short_forms/:id/schedule_callback_client"      => 'short_forms#schedule_callback_client'
  patch "short_forms/:id/delete"                 => 'short_forms#move_to_trash',  :as => 'trash_short_form'
  patch "short_forms/:id/cancel_visit"           => 'short_forms#cancel_visit',  :as => 'cancel_short_form'
  put   "short_forms/:id/verify"  =>  "short_forms#verify",  :as => 'verify_short_form'
  put   "short_forms/:id/submit"  =>  "short_forms#submit",  :as => 'submit_short_form'

  patch   "short_forms/rm_panel/:id/sent_to_bank"  =>  "short_forms/rm_panel#sent_to_bank",  :as => 'send_short_form_to_bank'
  patch   "short_forms/rm_panel/:id/callback_complete"  =>  "short_forms/rm_panel#callback_complete",  :as => 'callback_complete'
  patch   "short_forms/rm_panel/:id/documents_collected"  =>  "short_forms/rm_panel#documents_collected",  :as => 'documents_collected'
  patch   "short_forms/rm_panel/:id/file_logged_in"  =>  "short_forms/rm_panel#file_logged_in",  :as => 'file_logged_in'
  patch   "short_forms/rm_panel/:id/approve"  =>  "short_forms/rm_panel#approve",  :as => 'approve'
  patch   "short_forms/rm_panel/:id/reject"  =>  "short_forms/rm_panel#reject",  :as => 'reject'
  patch   "short_forms/rm_panel/:id/disburse"  =>  "short_forms/rm_panel#disburse",  :as => 'disburse'
  patch   "short_forms/rm_panel/:id/cancelled_by_rm"  =>  "short_forms/rm_panel#cancelled_by_rm",  :as => 'cancelled_by_rm'
  patch   "short_forms/rm_panel/:id/next_follow_up" => "short_forms/rm_panel#next_follow_up", :as => 'next_follow_up'
  patch   "short_forms/rm_panel/:id/rm_callback" => "short_forms/rm_panel#rm_callback", :as => 'short_forms_rm_callback'
  patch   "short_forms/rm_panel/rm_callback_complete" => "short_forms/rm_panel#rm_callback_complete", :as => "short_forms_rm_callback_complete"

  get   "short_forms/rm_apnel/callback_complete_field" => "short_forms/rm_panel#callback_complete_field", :as => 'short_forms_callback_complete_fields'
  get   "short_forms/rm_panel/documents_collected_field" => "short_forms/rm_panel#documents_collected_field", :as => 'short_forms_documents_collected_fields'
  get   "short_forms/rm_panel/file_logged_field" => "short_forms/rm_panel#file_logged_field", :as => 'short_forms_file_logged_fields'
  get   "short_forms/rm_panel/approved_field" => "short_forms/rm_panel#approved_field", :as => 'short_forms_approved_fields'
  get   "short_forms/rm_panel/disbursed_field" => "short_forms/rm_panel#disbursed_field", :as => 'short_forms_disbursed_fields'
  get   "short_forms/rm_panel/rejection_field" => "short_forms/rm_panel#rejection_field", :as => 'short_forms_rejection_fields'
  get   "short_forms/rm_panel/cancellation_field" => "short_forms/rm_panel#cancellation_field", :as => 'short_forms_cancellation_fields'
  get   "short_forms/rm_panel/:id/next_follow_up_field" => "short_forms/rm_panel#next_follow_up_field", :as => 'short_forms_next_follow_up_fields'
  get   "short_forms/rm_panel/:id/rm_callback_field" => "short_forms/rm_panel#rm_callback_field", :as => 'short_forms_rm_callback_fields'
  get   "short_forms/rm_panel/rm_callback_list" => "short_forms/rm_panel#rm_callback_list", :as => 'short_forms_rm_callback_list'
  get   "short_forms/rm_panel/:id/get_csrm_agents" => "short_forms/rm_panel#get_csrm_agents", :as => 'short_forms_get_csrm_agents'
  patch "short_forms/rm_panel/:id/set_csrm_agent" => "short_forms/rm_panel#set_csrm_agent"
  get   "short_forms/rm_panel/:id/get_rm_pocs" => "short_forms/rm_panel#get_rm_pocs", :as => 'short_forms_get_rm_pocs'
  patch "short_forms/rm_panel/:id/set_rm_poc" => "short_forms/rm_panel#set_rm_poc"
  patch "short_forms/rm_panel/:id/sms_rm_poc" => "short_forms/rm_panel#sms_rm_poc", :as => "short_forms_sms_rm_poc"

  get   "short_forms/edit_user_forms"  =>  "short_forms#edit_user_forms",  :as => 'edit_short_forms_of_user'
  get   "short_forms/show_user_forms"  =>  "short_forms#show_user_forms",  :as => 'show_short_forms_of_user'
  get   "short_forms/edit_search_short_form" => "short_forms#edit_search_short_form", :as => 'edit_search_short_form'
  get   "short_forms/show_search_short_form" => "short_forms#show_search_short_form", :as => 'show_search_short_form'
  patch   "short_forms/:id/update_search_panel_short_form" => "short_forms#update_search_panel_short_form", :as => 'update_search_panel_short_form'
  get   "short_forms/offers_page_mailer"  => "short_forms#offers_page_mailer", :as => 'offers_page_mailer'
  get   "short_forms/eligibility_page_mailer" => "short_forms#eligibility_page_mailer", :as => 'eligibility_page_mailer'
  get   "short_forms/download" => "short_forms#download"
  post   "short_forms/create_log" => "short_forms#create_log", :as => 'create_log'
  post   "short_forms/re_assign_user/:id"                => 'short_forms#re_assign_user', :as => "short_forms_re_assign_user"
  get    "short_forms/get_user_logs/:user_id"  => 'short_forms#get_user_logs', :as => 'short_forms_get_user_logs'

  resources :short_forms
  resources :long_form_data

  get "/banks/:id/show_city_tiers/" => 'banks#show_city_tier', :as => 'show_city_tier'
  get "/banks/:id/edit_city_tier/" => 'banks#edit_city_tier', :as => 'edit_city_tier'
  patch "/banks/:id/update_city_tier/" => 'banks#update_city_tier', :as => 'update_city_tier'

  get "/csrm_profiles/:id/cities" => 'csrm_profiles#cities', :as => 'csrm_cities'
  get "/csrm_profiles/:id/banks" => 'csrm_profiles#banks', :as => 'csrm_banks'
  get "/csrm_profiles/:id/employment_types" => 'csrm_profiles#employment_types', :as => 'csrm_employment_types'
  patch "/csrm_profiles/:id/update_cities" => "csrm_profiles#update_cities", :as => 'update_csrm_cities'
  patch "/csrm_profiles/:id/update_banks" => "csrm_profiles#update_banks", :as => 'update_csrm_banks'
  patch "/csrm_profiles/:id/update_employment_types" => "csrm_profiles#update_employment_types", :as => 'update_csrm_employment_types'

  namespace :api do
    namespace :v0 do
      get "filter_request"            => 'filter_api#filter_request'
      get  "get_initial_parameters"    => 'filter_api#get_initial_parameters'
      post "create_lead"               => 'client_token_api#create_lead', :as => "create_lead"
      post "submit_application"       => 'client_token_api#submit_application', :as => "submit_application"
      get "faqs/get_faq_details" => 'faqs_api#get_details'
      get "faqs/get_answer/:faq_id" => 'faqs_api#get_answer', :as => 'faqs_get_answer'

      get "track_your_application" => 'client_token_api#track_your_application', :as => 'track_your_application'
      get "get_draft_application" => 'client_token_api#get_draft_application', :as => 'get_draft_application'
      post "cancel_application" => 'client_token_api#cancel_application', :as => 'cancel_application'
      get "get_loan_offers" => 'filter_api#get_loan_offers', :as => 'get_loan_offers'
      post "callback"            => 'filter_api#callback'

      get "interest-rate"  => 'interest_rate_api#interest_rate'

      #################################################
      # Route to receive Single Sign Out request
      #################################################

      post "invalidate_session" => "single_signout#invalidate_session"

      #################################################
      # Route to receive Single Sign Out request
      #################################################
    end
  end

  namespace :api do
    namespace :v1 do
      #################################################
      # Routes to Handle OTP Requests
      #################################################

      match "view_offers", :controller => 'json_product_evaluator', :action => 'options', :constraints => {:method => 'OPTIONS'}, :via => [:options]
      post "send_otp" => 'otp#send_phone_verification_otp'
      post "verify_otp" => 'otp#verify_otp'
      get  "get_initial_parameters"    => 'filter_api#get_initial_parameters'

      get "get_relevant_documents" => "documents#get_relevant_documents"

      post "update_required_documents"  => 'documents#update_documents'

      get "all_applications" => "client_token_api#all_applications", :as => "all_applications"
      post "create_application" => "client_token_api#create_application", :as => "create_application"
      get  "bank_offers" => "json_product_evaluator#get_bank_offers"
      get "get_application_logs/:id" => "client_token_api#get_application_logs", :as => "get_application_logs"
      post "update_application/:id" => "client_token_api#update_application", :as => "update_application"
      post "submit_application"       => 'client_token_api#submit_application'
      post "submit_application_as_guest"       => 'client_token_api#submit_application_as_guest'
      post "clone_application/:id"       => 'client_token_api#clone_application'
      post "delete_application/:id" => 'client_token_api#delete_application'
      post "cancel_application/:id" => 'client_token_api#cancel_application'
      get "get_user_co_applicants" => 'client_token_api#get_user_co_applicants', :as => 'get_user_co_applicants'
      post "create_user_co_applicant" => 'client_token_api#create_user_co_applicant'
      post "update_user_co_applicant/:id" => 'client_token_api#update_user_co_applicant'
      post "delete_user_co_applicant/:id" => 'client_token_api#delete_user_co_applicant'
      get "get_short_form_co_applicants" => 'client_token_api#get_short_form_co_applicants'
      post "view_offers" => 'json_product_evaluator#view_offers'
      get "special_offers" => 'json_product_evaluator#special_offers'
      get "get_employers_list" => 'employers#get_employers_list'
      get "get_all_banks" => "banks#get_all_banks"
    end
  end

  get "cs_panel" => 'cs_panel#index'

  get '*path' => redirect('404.html')
  post '*path' => redirect('404.html')


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
