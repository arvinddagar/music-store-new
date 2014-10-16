class StudentsController < ApplicationController
  before_filter :redirect_user_with_incomplete_registration_stu
  skip_before_filter :redirect_user_with_incomplete_registration_stu,
                     only: [:complete_registration_stu, :complete_stu]
    before_filter :authenticate_user!,
                only: [:index,:reservations, :update,:complete_registration_stu,:mylist,:rate]
  respond_to :json
  
  layout 'application_new', :only => [:reservations,:index,:student_class,:mylist,:complete_registration_stu,:show]
  
  def index
    @upcoming_reservations= current_student.reservations.where("class_date > ?", Date.today).page(params[:page]).per(5)
    if params[:format] == "json"
      render json: @upcoming_reservations
    end
  end
  
  def student_class
    @past_reservations= current_student.reservations.where("class_date < ?", Date.today)
    @upcoming_reservations= current_student.reservations.where("class_date > ?", Date.today)
    if params[:format] == "json"
      render json: @past_reservations
    end
  end

  def rate
    if params[:rate]=="Average"
      val=2
    elsif params[:rate]=="Poor"
      val=1
    elsif params[:rate]=="Good"
      val=3
    elsif params[:rate]=="Very Good"
      val=4
    else
      val=5
    end     
    hash = {:lesson_id=>params[:lesson_id],:student_id=>current_student.id,:rate=>val}
    Rating.create(hash)
    @record=Rating.where(lesson_id:params[:lesson_id])
    sum=0
    @record.each do |record|
      sum=sum+record.rate.to_f
    end
    @lesson=Lesson.find(params[:lesson_id])
    @lesson.avg_rate=sum.to_f / @record.count
    @lesson.save
    redirect_to :action => 'student_class'
  end

  def mylist
    
    @favs=Favorite.where(:student => current_student).page(params[:page]).per(1)
    if params[:format] == "json"
      render json: @favs
    end
  end


  def new
    @student = Student.new
    @student.build_user
  end
  
  def reservations
    @reservations=current_student.reservations.all
    if params[:format] == "json"
      render json: @reservations
    end
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      sign_in @student.user
      format.json { render  @student }
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