class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:book_class , :favorite]
  
  def welcome
    if current_student.present?
      @fav = Favorite.where('student_id = ?' , current_student.id)
    else
      @featured_class = Lesson.where(:featured => true)
    end
  end
  
  def class_search
    address = current_student.address if current_student.present?
    if params[:price_search].present? and params[:price_search] == "Low to High"
      @lessons=Lesson.order(:price)
      render @lessons, layout: false
    elsif params[:price_search].present? and params[:price_search] == "High to Low"
      @lessons = Lesson.order("price DESC").all
      render @lessons, layout: false
    elsif params[:price_search].present? and params[:price_search] == "All Classes"
      @lessons = Lesson.all
      render @lessons, layout: false
    elsif params[:neighbourhood].present?
      @lessons = Lesson.where(neighbourhood: params[:neighbourhood])
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 1 Km"
      @lessons = Lesson.near(address, 1)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 2 Km"
      @lessons = Lesson.near(address, 2)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 3 Km"
      @lessons = Lesson.near(address, 3)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 4 Km"
      @lessons = Lesson.near(address, 4)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "With in 5 Km"
      @lessons = Lesson.near(address, 5)
      render @lessons, layout: false
    elsif params[:distance].present? and params[:distance] == "More than 5 Km"
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