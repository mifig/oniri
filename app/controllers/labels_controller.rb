class LabelsController < ApplicationController
  before_action :set_label, only: [:edit, :update, :destroy]

  def index
    @labels = policy_scope(Label)
  end
  
  def new
    @label = Label.new

    authorize @label
  end

  def create
    @label = Label.new(label_params)
    @label.user = current_user

    authorize @label

    if @label.save
      redirect_to labels_path
    else
      render :new
    end
  end

  def edit
    authorize @label
  end

  def update
    authorize @label
    
    if @label.update(label_params)
      redirect_to labels_path
    else
      render :edit
    end
  end

  def destroy
    authorize @label

    if @label.destroy
      redirect_to labels_path
    else
      render :index
    end
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:title, :color)
  end
end
