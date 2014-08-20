
class CommentsController < ApplicationController
  def create
    lesson          = Lesson.find(params[:lesson_id])
    comment         = lesson.comments.build comment_params
    comment.user_id = current_user.id
    redirect_to students_url if comment.save
  end

  private

  def comment_params
    attrs = []
    attrs.push(:comment, :lesson_id)
    params.require(:comment).permit(attrs)
  end
end