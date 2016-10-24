class Admin::LevelsController < ApplicationController
  before_action :load_level, except: [:index, :new, :create]

  def index
    @subjects = Subject.all
    @levels = Level.newest.paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end

  def edit
    @subjects = Subject.all
  end

  def show
  end

  def new
    @subjects = Subject.all
    @level = Level.new
  end

  def update
    if @level.update_attributes level_params
      flash.now[:success] = t "flash.success.updated_levels"
      redirect_to admin_levels_path
    else
      flash.now[:danger] = t "flash.danger.updated_levels"
      render :edit
    end
  end

  def create
    @level = Level.new level_params
    if @level.save
      flash[:success] = t "flash.susscess.create_levels"
      redirect_to admin_levels_path
    else
      flash[:danger] = t "flash.danger.created_levels"
      render :new
    end
  end

  def destroy
    if @level.destroy
      flash.now[:success] = t "flash.success.deleted_levels"
    else
      flash.now[:danger] = t "flash.danger.deleted_levels"
    end
    redirect_to admin_levels_path
  end

  private
    def level_params
      params.require(:level).permit :name, :question_number, :subject_id
    end

    def load_level
      @level = Level.find_by id: params[:id]
      unless @level
        flash.now[:danger] = t "flash.danger.level_not_found"
        redirect_to admin_levels_path
      end
    end
end
