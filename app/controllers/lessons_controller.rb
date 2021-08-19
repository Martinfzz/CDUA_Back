class LessonsController < ApplicationController
  before_action :authenticate!
  before_action :set_lesson, only: [:show, :update, :destroy]
  
  def index
    @lessons = Lesson.where(user_id: BSON::ObjectId.from_string(current_user.id.to_s))
    render json: @lessons
  end

  def show
    render json: @lesson
  end

  def create
    puts "--------------------"
    puts lesson_params
    puts "--------------------"
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      render json: @lesson, status: :created, location: @lesson
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  def update
    if @lesson.update(lesson_params)
      render json: @lesson
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find_by(id: BSON::ObjectId.from_string(params[:id]), user_id: BSON::ObjectId.from_string(current_user.id.to_s))
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.fetch(:lesson, {}).permit(:title, :content, :user_id)
    end
  
end
