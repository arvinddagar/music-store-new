class LessonsController < ApplicationController
  before_filter :authenticate_user!,
                only: [:new, :create,:edit,:update,:new_schedule,:create_schedule]
  def new
    @lesson = Lesson.new
    @lesson.pictures.build
  end

  def create
    @lesson = current_user.tutor.lessons.new(lesson_params)
    @lesson.save
    flash[:info] = 'Class created'
    redirect_to new_schedule_path(:lesson_id => @lesson)
  end

  def edit
    @lesson=Lesson.find(params[:id])
  end

  def update
    @lesson=Lesson.find(params[:id])
    if @lesson.update(update_lesson_params)
      flash[:info] = 'Class updated'
      redirect_to new_schedule_path(:lesson_id => @lesson)
    else
      flash[:info] = 'Some thing went wrong'
      redirect_to tutors_path
    end
  end
  
  def show
    @lesson=Lesson.find(params[:id])
    @reviews=@lesson.comments
  end
  
  def show_profile
    @tutor=Tutor.find(params[:id])
    @lessons=Tutor.find(params[:id]).lessons
  end

  def sub_category
    if  params[:parent_id].present?
      @subcategory = Category.where(parent_id: params[:parent_id])
      render partial: 'subcategory', layout: false, locals: { subcategory: @subcategory } and return
    end
    @lessons = Lesson.order(:address).page params[:page]
    render nothing: true and return
  end

  def category_search
    @category = Category.find(params[:id])
    @sub_category = params[:sub_category] ? Category.find(params[:sub_category]) : Category.where(parent_id: @category.id)
    @lessons = Lesson.where(category_id: @sub_category)
  end
  def new_schedule
    @new_schedule=Schedule.new
    1.times do
    day = @new_schedule.days.build
    2.times { day.timings.build }
    end
  end

  def create_schedule
    @new_schedule=Schedule.new(schedule_params)
    @new_schedule.save
    flash[:info] = 'Class Schedule created'
    redirect_to tutors_path
  end


  private
   def lesson_params
    params.require(:lesson).permit(:latitude, :longitude,:name,:description,:neighbourhood,:category_id,:address,:phone_no,:price,:duration,:publish,:maximum_people, pictures_attributes: [:image])
   end

   def update_lesson_params
    params.require(:lesson).permit(:latitude, :longitude,:name,:description,:neighbourhood,:category_id,:address,:phone_no,:price,:duration,:publish,:maximum_people, pictures_attributes: [:image,:id])
   end

   def schedule_params
    params.require(:schedule).permit(:lesson_id,days_attributes:[:id,:name,:date,:schedule_id,:_destroy,timings_attributes: [:id,:day_id,:start_time, :end_time,:_destroy]])
   end



end
