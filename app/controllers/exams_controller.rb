class ExamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @exam = current_user.exams.new
    @subjects = Subject.all
    @exams = current_user.exams.includes(:subject, :exam_questions).newest
      .paginate page: params[:page], per_page: Settings.pagination.per_page
  end

  def show
    @exam = Exam.find_by id: params[:id]
    @exam.update_status
    @exam.exam_questions.each do |exam_question|
      exam_question.build_exam_answers
    end
  end

  def create
    @exam = current_user.exams.new exam_params
    if @exam.save
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "flash.danger.created_exam"
      redirect_to exams_path
    end
  end

  def update
    @exam = Exam.find_by id: params[:id]
    if @exam.update_attributes exam_params
      @exam.update_status params[:finish]
      flash[:success] = t "flash.success.saved_exam"
    else
      flash[:danger] = t "flash.danger.saved_exam"
    end
    redirect_to exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id,
      exam_questions_attributes: [:id, exam_answers_attributes: [:id,
      :answer_id, :content, :_destroy]]
  end
end
