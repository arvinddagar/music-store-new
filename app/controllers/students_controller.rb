class StudentsController < ApplicationController
  before_filter :redirect_user_with_incomplete_registration_stu
  skip_before_filter :redirect_user_with_incomplete_registration_stu,
                     only: [:complete_registration_stu, :complete_stu]
    before_filter :authenticate_user!,
                only: [:index, :update,:complete_registration_stu]
  def index
    @upcoming_reservations= current_student.reservations.where("class_date > ?", Date.today)
  end
  def student_class
    @past_reservations= current_student.reservations.where("class_date < ?", Date.today)
    @upcoming_reservations= current_student.reservations.where("class_date > ?", Date.today)
  end

  def new
    @student = Student.new
    @student.build_user
  end
  
  def reservations
    # binding.pry
    @reservations=current_student.reservations.all
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      sign_in @student.user
      redirect_to root_url
    else
      flash.now[:alert] = 'Error in registration. !!'
      render :new
    end
  end
  def complete_registration_stu
    @student = current_user.student
  end

  def complete_stu
    @student = current_user.student
    if @student.update(student_update_params)
    flash[:info] = 'Profile updated successfully'
    redirect_to students_url
    end
  end

  def show
    @student = current_student
  end


  def student_params
    params.require(:student)
          .permit(:first_name,:last_name, user_attributes: [:email, :password,:user_type])
  end
  def student_update_params
    params.require(:student).permit(:address, :image)
  end

end