class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    @posts = Post.all.paginate(page: page, per_page: per_page)
  end
  
  def top
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @top_posts = Post.order('average_rating DESC').paginate(page: page, per_page: per_page)
    # render json: PostSerializer.new(@top_posts).serialized_json
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    
    # if @post.save
    #   render json: PostSerializer.new(@post).serialized_json, status: :created
    # else
    #   render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    # end
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
