ActiveAdmin.register Tutor do

 form do |f|
    f.inputs do
      f.input :email, for: :user
      f.input :password, for: :user
    end
    f.inputs do
      f.input :first_name
      f.input :last_name
    end
    f.actions
  end
  index do
    column :user
    column :first_name
    column :last_name
    actions
  end

  member_action :change_password, method: :post do
    @tutor = Tutor.find(params[:id])
  end


  action_item only: [:show, :edit] do
    link_to 'Change Email/Password', change_password_admin_tutor_path(tutor), method: :post
  end
  action_item :only => :show do
    link_to('Complete profile',complete_profile_path)
  end

  controller do
    def permitted_params
      params.permit :utf8, :_method, :_wysihtml5_mode,
                    :authenticity_token, :commit, :id,
                    tutor: [:first_name,:last_name, :user_id, :email, user_attributes: [:id ,:password]]
    end

    def new
      @tutor = Tutor.new
      @tutor.build_user
    end
    def complete_profile

      @tutor = Tutor.find(params[:id])
      if request.method=='POST'
      @tutor.update(:description=>params[:tutor][:description],:address=>params[:tutor][:address],:about_me=>params[:tutor][:about_me],:skills=>params[:tutor][:skills],:teaching_philosophy=>params[:tutor][:teaching_philosophy],:age_group=>params[:tutor][:age_group],:cre=>params[:tutor][:cre],:duration=>params[:tutor][:duration],:instruments=>params[:tutor][:instruments],:experience=>params[:tutor][:experience])
      binding.pry
      redirect_to admin_tutors_url
    end
    end

    def create
      tutor = User.find_or_create_by(email: params[:tutor][:email]) do |u|
        u.password = params[:tutor][:password]
      end
      Tutor.find_or_create_by(first_name: params[:tutor][:first_name], last_name: params[:tutor][:last_name]) do |u|
        u.user = tutor
      end
      redirect_to admin_tutors_url
    end

    def update
      tutor = Tutor.find(params[:id])
      if params[:tutor][:user_attributes].present?
        if params[:tutor][:user_attributes][:id]
          user = User.find params[:tutor][:user_attributes][:id]
          #binding.pry
          #user.update_attribute('email', params[:student][:user_attributes][:email]) if params[:student][:user_attributes][:email].present?
          #user.update_attribute('password', params[:student][:user_attributes][:password]) && sign_in(current_admin_user, bypass: true) if params[:student][:user_attributes][:password].present?
        end
        render :edit, notice: 'Updated Successfully.'
      else
        super
      end
    end
  end


end
