class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :null_session
  # protect_from_forgery with: :exception
  helper_method :current_student,
                :category_list,
                :current_tutor
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.type == :student && session[:return_to]
      session.delete(:return_to)
    elsif resource.is_a?(AdminUser)
      admin_root_url
    elsif resource.is_a?(User) && resource.type == :student
     students_url
    elsif resource.is_a?(User) && resource.type == :tutor
      tutors_url
    else
      students_url
    end
  end

  def redirect_user_with_incomplete_registration
    return if request.path == destroy_user_session_path
    if current_user && current_user.role && current_user.role.incomplete?
      redirect_to complete_registration_url
    end
  end

  def redirect_user_with_incomplete_registration_stu
    return if request.path == destroy_user_session_path
    if current_user && current_user.role && current_user.role.incomplete?
      redirect_to complete_registration_stu_url
    end
  end


  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def current_student
    current_user && current_user.student
  end

  def current_tutor
    current_user && current_user.tutor
  end

  def category_list
    @categories ||= Category.main_categories
  end
end