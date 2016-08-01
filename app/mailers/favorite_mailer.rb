class FavoriteMailer < ApplicationMailer
  default from: "tedsappington@gmail.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@warm-scrubland-60037.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@warm-scrubland-60037.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@warm-scrubland-60037.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(post)

      headers["Message-ID"] = "<posts/#{post.id}@warm-scrubland-60037.herokuapp.com>" # VIDEO SOLUTION
      headers["In-Reply-To"] = "<post/#{post.id}@warm-scrubland-60037.herokuapp.com>"
      headers["References"] = "<post/#{post.id}@warm-scrubland-60037.herokuapp.com>"

      @post = post

#      mail(to: user.email, subject: "You've been automatically favorite'ed on your post: #{post.title}")
      mail(to: post.user.email, subject: "You've been automatically favorite'ed on your post: #{post.title}") # VIDEO SOLUTION
  end


end
