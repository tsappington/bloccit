class PostsController < ApplicationController
  def index
    @posts = Post.all

    @posts.first.update!( title: "SPAM" )
    @posts.each_with_index do |post, x|
        post.update!( title: "SPAM" ) if (x % 5) == 0
    end

  end

  def show
  end

  def new
  end

  def edit
  end



end
