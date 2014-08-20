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
  patch 'complete', to: 'tutors#complete'
  get 'complete_registration_stu', to: 'students#complete_registration_stu'
  patch 'complete_stu', to: 'students#complete_stu'
  get 'tutors/profile' => 'tutors#show'
  get 'students/profile' => 'students#show'
  get 'category/:id' => 'lessons#category_search', as: :category
  get 'category/:id/:sub_category' => 'lessons#category_search', as: :subcategory
  get 'subcategory', to: 'lessons#sub_category'
  get 'search_classes', to: 'home#class_search'
  get 'check_username' => "tutors#check_username"
   get 'check_unique_uname' => "tutors#check_unique_uname"
   get 'reservations' => 'students#reservations'
   get 'student_class' => 'students#student_class'
   match 'feedback_reminder' => 'tutors#feedback_reminder',via:[:get,:post]
   get 'new_schedule' => 'lessons#new_schedule'
   post 'create_schedule' => 'lessons#create_schedule'
   authenticated :user do
    resources :conversations, only: [:index, :show, :new, :create, :send] do
      member do
        post :reply
        post :trash
        post :untrash
      end
    end
  end
end
