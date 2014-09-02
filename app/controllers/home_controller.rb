class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:book_class]
  
  def welcome
    @featured_class = Lesson.where(:featured => true)
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
end