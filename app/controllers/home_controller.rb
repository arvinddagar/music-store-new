class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:book_class]
  
  def welcome
  end
  
  def class_search
    if params[:search].present?
  	  @lessons=Lesson.search(params[:search])
    else
      @lessons = Lesson.all
    end
  end

  def book_class
    @lesson=Lesson.find(params[:id])
  end

end