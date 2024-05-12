class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    @reviews = Review.all.paginate(page: page, per_page: per_page)
  end

  def show; end

  def new
    @review = Review.new
  end

  def edit; end

  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to review_url(@review), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
    # if @review.save
    #   render json: ReviewSerializer.new(@review).serialized_json, status: :created
    # else
    #   render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    # end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :user_id, :post_id)
  end
end
