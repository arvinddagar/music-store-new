class TutorsController < ApplicationController
  before_filter :redirect_user_with_incomplete_registration
  skip_before_filter :redirect_user_with_incomplete_registration,
                     only: [:complete_registration, :complete]
  before_filter :authenticate_user!,
                only: [:index, :update, :complete_registration]
  
  layout 'application_new', :only => [:index,:complete_registration,:new,:show]
  def new
    @tutor = Tutor.new
    @tutor.build_user
    @student = Student.new
    @student.build_user
  end
  
  def feedback_reminder
    @lessons=Lesson.all
    @lessons.each do |reser|
      @reservation=reser.reservations
      @past_reservations=@reservation.where("class_date < ?", Date.today)
      if @past_reservations.present?
        @past_reservations.each do |stud|
          if stud.lesson.comments.blank?
            @user=stud.student.user
          end
        end
      end
    end
    # if @user.present?
    # NotifierMailer.feedback_reminder(@user).deliver
    # end
    redirect_to tutors_url
  end

  def index
    @lessons=current_tutor.lessons.page(params[:page]).per(5)
    if params[:format] == "json"
      render json: @lessons
    end
  end

  def create
    @tutor = Tutor.new(tutor_params)
    if @tutor.save
      sign_in @tutor.user
      redirect_to root_url
      format.json { render  @tutor }
    else
      flash.now[:alert] = 'Error in registration'
      render :new
    end
  end

  def show
    @tutor = current_tutor
    @lessons=@tutor.lessons
  end


  def complete_registration
    @tutor = current_user.tutor
    if params[:format] == "json"
      render json: @tutor
    end
  end

  def complete
    @tutor = current_user.tutor
    if @tutor.update(tutor_update_params)
    flash[:info] = 'Profile updated successfully'
    redirect_to tutors_url
    end
  end
  def check_username

    @username = "#{params[:first_name]}_#{params[:last_name]}"
    @validuname = Tutor.find_by(user_name: @username)

    if @validuname.present?
      respond_with("username not available please enter new")
    else
      respond_with(@username)
    end
  end
  def check_unique_uname
    uname = params[:username]
     @validuname = Tutor.find_by(user_name: uname)
     if @validuname.present?
       respond_with("username not available please enter new")
     else
       respond_with(@username+ "-done")

     end
  end

  def my_earning
    # binding.pry
    today = Date.today # Today's date
    @days_from_this_week = (today.at_beginning_of_week..today.at_end_of_week).map
    @my_earnings =  Earning.where("tutor_id = #{current_tutor.id}")
    if params[:format] == "json"
      render json: @my_earnings
    end
  end


  private

  def tutor_params
    params.require(:tutor).permit( :user_name,:first_name,:last_name, user_attributes: [:email, :password, :user_type ])
  end


  def tutor_update_params
   params.require(:tutor).permit(:description, :about_me, :duration, :skills , :teaching_philosophy , :cre, :age_group , :instruments ,:experience,:image,:address, :latitude, :longitude)
 end

end