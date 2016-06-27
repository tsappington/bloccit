class CommentsController < ApplicationController

  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create

    if params[:post_id]
      @comment_type = Post.find(params[:post_id])
    elsif params[:topic_id]
      @comment_type = Topic.find(params[:topic_id])
    end
    comment = @comment_type.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
      if params[:post_id]
        redirect_to [@comment_type.topic, @comment_type]
      elsif params[:topic_id]
        redirect_to [@comment_type]
      end
    else
      flash[:alert] = "Comment failed to save."
      redirect_to [@comment_type]
    end
  end

  def destroy
    if params[:post_id]
      @comment_type = Post.find(params[:post_id])
    elsif params[:topic_id]
      @comment_type = Topic.find(params[:topic_id])
    end
    comment = @comment_type.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      if params[:post_id]
        redirect_to [@comment_type.topic, @comment_type]
      elsif params[:topic_id]
        redirect_to [@comment_type]
      end
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@comment_type]
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end

end
