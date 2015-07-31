class QuizzesController < ApplicationController

  def index
    @quizzes = Quiz.all
  end

  def new
    @quiz = Quiz.new
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def create
    binding.pry
    @quiz = Quiz.new quiz_params
    @quiz.users << current_user
    #add questions to the quiz
    @quiz.save
    redirect_to quiz_path(@quiz)
  end

  private

  def quiz_params
    params.require(:quiz).permit(:name, :questions)
  end
end
