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
    if params[:price_search].present? and params[:price_search] == "Low to High"
      @lessons=Lesson.order(:price)
      render @lessons, layout: false
    elsif params[:price_search].present? and params[:price_search] == "High to Low"
      @lessons = Lesson.order("price DESC").all
      render @lessons, layout: false
    elsif params[:neighbourhood].present?
      @lessons = Lesson.where(neighbourhood: params[:neighbourhood])
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
    Favorite.create(:tutor_id =>  params[:tutor] , :student_id => current_student.id)
    redirect_to students_path
  end

  def un_favorite
    Favorite.find_by('student_id = ? AND tutor_id = ?' , current_student.id , params[:tutor]).destroy
    redirect_to students_path
  end


end