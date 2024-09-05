class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update]
  before_action :get_user
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    redirect_back fallback_location: posts_path unless @user
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    redirect_back fallback_location: posts_path unless helpers.can_edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = @user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    redirect_back fallback_location: posts_path unless helpers.can_edit
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  # def destroy
  #   @post.destroy!
  #
  #   respond_to do |format|
  #     format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def get_user
      @user = User.find_by(id: session[:user_id])
    end
end
