module PostsHelper
  def can_edit()
    @user == @post.user
  end
end
