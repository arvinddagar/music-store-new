Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :students
  resources :tutors
  resources :lessons
  resources :charges
  resources :lessons, only: [:show] do
    resources :comments, only: [:create, :destroy]
  end
  root 'home#welcome'
  get 'book_class/:id', to: 'home#book_class', as: :book_class
  get 'complete_registration', to: 'tutors#complete_registration'
  get 'reschedule', to: 'charges#reschedule'
  get 'add_fav', to: 'home#favorite'
  get 'remove_fav', to: 'home#un_favorite'
  patch 'complete', to: 'tutors#complete'
  get 'complete_registration_stu', to: 'students#complete_registration_stu'
  patch 'complete_stu', to: 'students#complete_stu'
  get 'tutors/profile' => 'tutors#show'
  get 'students/profile' => 'students#show'
  get 'my_wish_list' => 'students#mylist'
  get 'category/:id' => 'lessons#category_search', as: :category
  get 'category/:id/:sub_category' => 'lessons#category_search', as: :subcategory
  get 'subcategory', to: 'lessons#sub_category'
  get 'search_classes', to: 'home#class_search'
  get 'check_username' => "tutors#check_username"
  get 'check_unique_uname' => "tutors#check_unique_uname"
  get 'reservations' => 'students#reservations'
  get 'student_class' => 'students#student_class'
  get 'my_earning' => 'tutors#my_earning'
  match 'feedback_reminder' => 'tutors#feedback_reminder',via:[:get,:post]
  get  'schedule/:lesson_id/edit' => 'lessons#edit_schedule', as: "edit_schedule"
  patch 'schedule/:lesson_id' => 'lessons#update_schedule', as: "update_schedule"
  get 'new_schedule' => 'lessons#new_schedule'
  post 'create_schedule' => 'lessons#create_schedule'
  match 'complete_profile/:id' => 'admin/tutors#complete_profile',via:[:get,:post,:patch], as: :complete_profile
  match 'complete_p' => 'admin/tutors#complete_p',via:[:get,:post,:patch]
  get 'ajaxsearch', to: 'home#class_search'
  # get 'ghan', to: 'lessons#ghan'
  get 'map' => 'lessons#map'
  # get 'find_neighbour', to: 'lessons#find_neighbour'
  get 'show_profile' =>'lessons#show_profile'
  post  'rate' =>'students#rate'

  authenticated :user do
    resources :conversations, only: [:index, :show, :new, :create, :send] do
      member do
        post :reply
        post :trash
        post :untrash
      end
    end
  end

    resources :conversations, only: [:index, :show, :new, :create] do
      member do
        post :reply
        post :trash
        post :untrash
      end
    end

end
