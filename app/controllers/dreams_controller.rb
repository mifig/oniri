class DreamsController < ApplicationController
  before_action :set_dream, only: [:show, :edit, :update, :destroy]
  after_action :verify_policy_scoped, only: [:index, :activity], unless: :skip_pundit?
  after_action :verify_authorized, except: [:index, :activity], unless: :skip_pundit?
  
  def index
    @dreams = policy_scope(Dream)
  end

  def activity
    @dreams = policy_scope(Dream)

    if params.dig(:search, :begin_date).present? && params.dig(:search, :end_date).present?
      @dreams = @dreams.where(dream_date: params.dig(:search, :begin_date)..params.dig(:search, :end_date), 
                              user_id: current_user.id)

      @dreams_by_lable = group_dreams_by_lable(query: true)
      @dreams_by_significance = group_dreams_by_significance(query: true)
    else
      @dreams_by_lable = group_dreams_by_lable(query: false)
      @dreams_by_significance = group_dreams_by_significance(query: false)
    end

    @label_colors = get_label_colors()
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

  def group_dreams_by_lable(query)
    if query
      DreamLabel.joins(:label)
                .joins(:dream)
                .where("dreams.dream_date": params.dig(:search, :begin_date)..params.dig(:search, :end_date),
                                                       user_id: current_user.id)
                .select("labels.title, dream_labels.id")
                .group("labels.title")
                .count("labels.title")
    else
      DreamLabel.joins(:label)
                .select("labels.title, dream_labels.id")
                .group("labels.title")
                .count("labels.title")
    end
  end

  def get_label_colors
    @dreams_by_lable.keys.map do |label| 
      Label.find_by(title: label).color 
    end
  end

  def group_dreams_by_significance(query)
    if query
      Dream.joins(:significance)
          .where("dreams.dream_date": params.dig(:search, :begin_date)..params.dig(:search, :end_date),
                                                  user_id: current_user.id)
          .select("significances.sign_type, dreams.id")
          .group("significances.sign_type")
          .count("significances.sign_type")
    else
      Dream.joins(:significance)
          .select("significances.sign_type, dreams.id")
          .group("significances.sign_type")
          .count("significances.sign_type")
    end
  end
end
