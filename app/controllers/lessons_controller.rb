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
      redirect_to tutors_path
    else
      flash[:info] = 'Some thing went wrong'
      redirect_to tutors_path
    end
  end


  def edit_schedule
  @new_schedule=Lesson.find(params[:lesson_id]).schedule
  end

  def  update_schedule
    @new_schedule=Lesson.find(params[:lesson_id]).schedule
    if @new_schedule.update_attributes(schedule_params)
      flash[:info] = 'schedule updated'
      redirect_to tutors_path
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

  def map
    @lessons = Lesson.where('latitude is NOT NULL and longitude is NOT NULL')
    @hash = ::Gmaps4rails.build_markers(@lessons) do |lesson, marker|
      marker.lat lesson.latitude
      marker.lng lesson.longitude
      lesson_detail = "#{lesson.description} by #{lesson.tutor.first_name}. Price #{(lesson.price)}. Class Strength #{lesson.maximum_people}. <a href='#{lesson_url(lesson)}'>Check It</a>"
      marker.infowindow lesson_detail
      marker.json({title: lesson.name})
    end
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
    if params[:price_search].nil? and params[:neighbourhood].nil?
      @category = Category.find(params[:id])
      @sub_category = params[:sub_category] ? Category.find(params[:sub_category]) : Category.where(parent_id: @category.id)
      @lessons = Lesson.where(category_id: @sub_category)
    else
      @category = Category.find(params[:category])
      @sub_category = params[:sub_category] ? Category.find(params[:sub_category]) : Category.where(parent_id: @category.id)
      @lessons = Lesson.where(category_id: @sub_category)
      if params[:price_search].present? and params[:price_search] == "Low to High" and params[:neighbourhood].nil?
        @lessons=@lessons.order(:price)
        render @lessons, layout: false
      elsif params[:price_search].present? and params[:price_search] == "High to Low" and params[:neighbourhood].nil?
        @lessons = @lessons.order("price DESC").all
        render @lessons, layout: false
      else
        @lessons = @lessons.where(neighbourhood: params[:neighbourhood])
        render @lessons, layout: false
      end
    end
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