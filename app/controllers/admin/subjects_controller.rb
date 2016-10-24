class Admin::SubjectsController < ApplicationController
  before_action :verify_admin
  before_action :load_subject, except: [:index, :new, :create]

  def index
    # @subject = Subject.new
    @subjects = Subject.newest.paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end

  def new
    @subject = Subject.new
  end

  def edit
  end

  def show
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "flash.susscess.create_subject"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t "flash.danger.created_subject"
      render :new
    end
  end

  def update
    if @subject.update_attributes subject_params
      flash.now[:success] = t "flash.success.updated_subject"
      redirect_to admin_subjects_path
    else
      flash.now[:danger] = t "flash.danger.updated_subject"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash.now[:success] = t "flash.success.deleted_subject"
    else
      flash.now[:danger] = t "flash.danger.deleted_subject"
    end
    redirect_to admin_subjects_path
  end

  private
    def subject_params
      params.require(:subject).permit :name, :question_number, :duration
    end

    def load_subject
      @subject = Subject.find_by id: params[:id]
      unless @subject
        flash.now[:danger] = t "flash.danger.subject_not_found"
        redirect_to admin_subjects_path
      end
    end
end
