class HomeController < ApplicationController

before_filter :authenticate_user!, only: [:book_class]

def welcome
end

def class_search
  @lessons = Lesson.all
end

def book_class
  @lesson=Lesson.find(params[:id])
end

end