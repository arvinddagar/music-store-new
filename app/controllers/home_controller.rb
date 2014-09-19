class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:book_class , :favorite]
    respond_to :json
  
  def welcome
    if current_student.present?
      @fav = Favorite.where('student_id = ?' , current_student.id)
      @array = Array.new
      @fav.each do |temp|
        temp.tutor.lessons.each do |object|
          @array << object
        end
      end
    else
      @featured_class = Lesson.where(:featured => true)
    end
  end
  
  def class_search
    @lessons_price=Lesson.all.sort { |a, b| b.price.to_i <=> a.price.to_i }
    address = current_student.address if current_student.present?
    if params[:price_search].present? and params[:price_search] == "Low to High"
      @lessons=@lessons_price.reverse
      render @lessons, layout: false
    elsif params[:price_search].present? and params[:price_search] == "High to Low"
      @lessons=@lessons_price
      render @lessons, layout: false
    elsif params[:rating].present? and params[:rating] == "Low to High"
      @lessons=Lesson.order(:avg_rate)
      render @lessons, layout: false
    elsif params[:rating].present? and params[:rating] == "High to Low"
      @lessons = Lesson.order("avg_rate desc")
      render @lessons, layout: false
    elsif params[:price_search].present? and params[:price_search] == "All Classes"
      @lessons = Lesson.all
      render @lessons, layout: false
    elsif params[:neighbourhood].present?
      @lessons = Lesson.where(neighbourhood: params[:neighbourhood])
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 1 Miles"
      @lessons = Lesson.near(address, 1)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 2 Miles"
      @lessons = Lesson.near(address, 2)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 3 Miles"
      @lessons = Lesson.near(address, 3)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 4 Miles"
      @lessons = Lesson.near(address, 4)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 5 Miles"
      @lessons = Lesson.near(address, 5)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "More than 5 Miles"
      @lessons = Lesson.all
      render @lessons, layout: false
    elsif params[:curdistance].present? and params[:curdistance] == "With in 1 Miles"
      @lessons = Lesson.near(params[:current_area],1)
      render @lessons, layout: false
    elsif params[:curdistance].present? and params[:curdistance] == "With in 2 Miles"
      @lessons = Lesson.near(params[:current_area],2)
      render @lessons, layout: false
    elsif params[:curdistance].present? and params[:curdistance] == "With in 3 Miles"
      @lessons = Lesson.near(params[:current_area],3)
      render @lessons, layout: false
    elsif params[:curdistance].present? and params[:curdistance] == "With in 4 Miles"
      @lessons = Lesson.near(params[:current_area],4)
      render @lessons, layout: false
    elsif params[:curdistance].present? and params[:curdistance] == "With in 5 Miles"
      @lessons = Lesson.near(params[:current_area],5)
      render @lessons, layout: false
    elsif params[:curdistance].present? and params[:curdistance] == "More than 5 Miles"
      @lessons = Lesson.all
      render @lessons, layout: false
    elsif params[:search].present?
  	  @lessons=Lesson.search(params[:search])
    else
      @lessons = Lesson.all
    end
  end
  def book_class
    @lesson=Lesson.find(params[:id])
  end

  def favorite
    if Favorite.create(:tutor_id =>  params[:tutor] , :student_id => current_student.id)
      flash[:info] = 'Tutor added to your Favorite List'
      redirect_to students_path
    end
  end

  def un_favorite
    if Favorite.find_by('student_id = ? AND tutor_id = ?' , current_student.id , params[:tutor]).destroy
      flash[:info] = 'Tutor removed from your Favorite List'
      redirect_to students_path
    end
  end
end