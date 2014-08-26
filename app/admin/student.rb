# /app/admin/student.rb
ActiveAdmin.register Student do
  # actions :all, except: [:new]
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
    @student = Student.find(params[:id])
  end

  action_item only: [:show, :edit] do
    link_to 'Change Email/Password', change_password_admin_student_path(student), method: :post
  end

  controller do
    def permitted_params
      params.permit :utf8, :_method, :_wysihtml5_mode,
                    :authenticity_token, :commit, :id,
                    student: [:first_name,:last_name, :user_id, :email, user_attributes: [:id ,:password]]
    end

    def new
      @student = Student.new
      @student.build_user
    end

    def create
      student = User.find_or_create_by(email: params[:student][:email]) do |u|
        u.password = params[:student][:password]
      end
      Student.find_or_create_by(first_name: params[:student][:first_name], last_name: params[:student][:last_name]) do |u|
        u.user = student
      end
      redirect_to admin_students_url
    end

    def update
      student = Student.find(params[:id])
      if params[:student][:user_attributes].present?
        if params[:student][:user_attributes][:id]
          user = User.find params[:student][:user_attributes][:id]
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
