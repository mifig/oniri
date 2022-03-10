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
      if params[:dream][:label_ids]
        params[:dream][:label_ids].each do |label_id|
          label = Label.find(label_id)
          DreamLabel.create(label: label, dream: @dream, user: current_user)
        end
      end

      redirect_to dream_path(@dream)
    else
      render :new
    end
  end
  
  def edit
    authorize @dream
  end

  def update
    authorize @dream
    
    if @dream.update(dream_params)
      destroy_labels = @dream.labels.where.not(id: params[:dream][:label_ids])
      DreamLabel.where(label: destroy_labels, dream: @dream, user: current_user).destroy_all
      
      if params[:dream][:label_ids]
        params[:dream][:label_ids].each do |label_id|
          label = Label.find(label_id)
          if !DreamLabel.exists?(label: label, dream: @dream, user: current_user)
            DreamLabel.create(label: label, dream: @dream, user: current_user)
          end
        end
      end

      redirect_to dream_path(@dream)
    else
      render :edit
    end
  end

  def destroy
    authorize @dream
    
    if @dream.destroy
      redirect_to :root
    else
      render :show
    end
  end

  private

  def dream_params
    params.require(:dream).permit(:title, :content, :dream_date, :significance_id, :label_ids, :user_id)
  end

  def set_dream
    @dream = Dream.find(params[:id])
  end
end
