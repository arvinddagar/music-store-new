class LessonsController < ApplicationController
  before_filter :authenticate_user!,
                only: [:new, :create,:edit,:update,:new_schedule,:create_schedule]
 
  layout 'application_new', :only => [:new_schedule,:show_profile,:show,:edit,:new,:create,:update]  
  # layout 'application', :only => [:new_schedule]
  def new
    @lesson = Lesson.new
    if params[:format] == "json"
      render json: @lesson
    end
    # @lesson.pictures.build
  end

  def ghan
    #binding.pry
    #  @new_schedule=Schedule.new(schedule_params)
    # @new_schedule.save
    # flash[:info] = 'Class Schedule created'
    # redirect_to tutors_path
  end

  
  def create
    @lesson = current_user.tutor.lessons.new(lesson_params)
    if @lesson.save
      i=0
      @fav = Favorite.where(:tutor => current_tutor)
      if !@fav.empty?
        while i < @fav.count
          # @fav[i].student.user
          NotifierMailer.lesson_confirmation(@fav[i].student.user).deliver
          i=i+1
        end
      end
      flash[:info] = 'Class created'
      redirect_to new_schedule_path(:lesson_id => @lesson)
      # format.json { render  @lesson }
    end
  end

  def edit
    @lesson=Lesson.find(params[:id])
  end

  def update
    # binding.pry
    @lesson=Lesson.find(params[:id])
    if @lesson.update(update_lesson_params)
      if !@lesson.schedule.nil?
        @timings=Timing.where(:day => Lesson.find(params[:id]).schedule.days)
        j=0
        while j < @timings.count
          @timings[j].max_people = params[:lesson][:maximum_people].to_i - @timings[j].booked 
          @timings[j].save
          j=j+1 
        end
      end

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
    session['referer'] = request.env["HTTP_REFERER"]
    @tutor=Tutor.find(params[:id])
    @lessons=Tutor.find(params[:id]).lessons
    if "#{params[:id]}".split(//).last(4).join == "json"
      render json: @tutor
    end
    # respond_to do |format|
    #   format.html # show.html.erb
    #   # format.json { :id => @tutor.id, :format => :json }
    #   #format.json { render json: @tutor,:id => @tutor.id }
    # end
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
    if params[:price_search].nil? and params[:neighbourhood].nil? and params[:rating].nil? and params[:curdistance].nil? and params[:distance].nil? 
      @category = Category.find(params[:id])
      @sub_category = params[:sub_category] ? Category.find(params[:sub_category]) : Category.where(parent_id: @category.id)
      @lessons = Lesson.where(category_id: @sub_category)
    else
      address = current_student.address if current_student.present?
      @category = Category.find(params[:category])
      @sub_category = params[:sub_category] ? Category.find(params[:sub_category]) : Category.where(parent_id: @category.id)
      @lessons = Lesson.where(category_id: @sub_category)
      @lessons_price=@lessons.all.sort { |a, b| b.price.to_i <=> a.price.to_i }
      if params[:price_search].present? and params[:price_search] == "Low to High"
        @lessons=@lessons_price.reverse
        render @lessons, layout: false
      elsif params[:price_search].present? and params[:price_search] == "High to Low"
        @lessons=@lessons_price
        render @lessons, layout: false
      elsif params[:neighbourhood].present?
        @lessons = @lessons.where(neighbourhood: params[:neighbourhood])
        render @lessons, layout: false
      elsif params[:rating].present? and params[:rating] == "Low to High"
        @lessons=@lessons.order(:avg_rate)
        render @lessons, layout: false
      elsif params[:rating].present? and params[:rating] == "High to Low"
        @lessons = @lessons.order("avg_rate desc")
        render @lessons, layout: false
      elsif params[:curdistance].present? and params[:curdistance] == "With in 1 Miles"
        @lessons = @lessons.near(params[:current_area],1)
        render @lessons, layout: false
      elsif params[:curdistance].present? and params[:curdistance] == "With in 2 Miles"
        @lessons = @lessons.near(params[:current_area],2)
        render @lessons, layout: false
      elsif params[:curdistance].present? and params[:curdistance] == "With in 3 Miles"
        @lessons = @lessons.near(params[:current_area],3)
        render @lessons, layout: false
      elsif params[:curdistance].present? and params[:curdistance] == "With in 4 Miles"
        @lessons = @lessons.near(params[:current_area],4)
        render @lessons, layout: false
      elsif params[:curdistance].present? and params[:curdistance] == "With in 5 Miles"
        @lessons = @lessons.near(params[:current_area],5)
        render @lessons, layout: false
      elsif params[:curdistance].present? and params[:curdistance] == "More than 5 Miles"
        @lessons = @lessons.all
        render @lessons, layout: false
      elsif params[:distance].present? and params[:distance] == "With in 1 Miles"
        @lessons = @lessons.near(address, 1)
        render @lessons, layout: false
      elsif params[:distance].present? and params[:distance] == "With in 2 Miles"
        @lessons = @lessons.near(address, 2)
        render @lessons, layout: false
      elsif params[:distance].present? and params[:distance] == "With in 3 Miles"
        @lessons = @lessons.near(address, 3)
        render @lessons, layout: false
      elsif params[:distance].present? and params[:distance] == "With in 4 Miles"
        @lessons = @lessons.near(address, 4)
        render @lessons, layout: false
      elsif params[:distance].present? and params[:distance] == "With in 5 Miles"
        @lessons = @lessons.near(address, 5)
        render @lessons, layout: false
      elsif params[:distance].present? and params[:distance] == "More than 5 Miles"
        @lessons = @lessons.all
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
    params.require(:lesson).permit(:latitude, :longitude,:name,:description,:neighbourhood,:category_id,:address,:phone_no,:price,:duration,:publish,:maximum_people, pictures_attributes: [:id,:image,:_destroy])
   end

   def update_lesson_params
    params.require(:lesson).permit(:latitude, :longitude,:name,:description,:neighbourhood,:category_id,:address,:phone_no,:price,:duration,:publish,:maximum_people, pictures_attributes: [:image,:id,:_destroy])
   end

   def schedule_params
    params.require(:schedule).permit(:lesson_id,days_attributes:[:id,:name,:date,:schedule_id,:_destroy,timings_attributes: [:id,:max_people,:day_id,:start_time, :end_time,:_destroy]])
   end
end