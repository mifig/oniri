class DreamsController < ApplicationController
  before_action :set_dream, only: [:show, :edit, :update, :destroy]

  def index
    @dreams = policy_scope(Dream)
  end

  def show
    authorize @dream
  end

  def new
    @dream = Dream.new

    authorize @dream
  end

  def create
    @dream = Dream.new(dream_params)
    @dream.user = current_user
    
    authorize @dream
    
    if @dream.save
      dream_labels = params[:dream][:label_ids].map do |label_id|
        label = Label.find(label_id)
        DreamLabel.create(label: label, dream: @dream)
      end

      redirect_to dream_path(@dream)
    else
      render :new
    end
  end
  
  def edit
  end

  def update
  end

  def destroy
  end

  private

  def dream_params
    params.require(:dream).permit(:title, :content, :dream_date, :significance_id, :label_ids)
  end

  def set_dream
    @dream = Dream.find(params[:id])
  end
end
