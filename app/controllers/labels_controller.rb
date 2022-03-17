class LabelsController < ApplicationController
  before_action :set_label, only: [:edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :query], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index, :query], unless: :skip_pundit?

  def index
    @labels = policy_scope(current_user.labels)
  end

  def query
    @filtered_labels = policy_scope(current_user.labels)

    if params.dig(:search, :title).present?
      filter_by_label_title
    end

    filtered_dreams_id = DreamLabel.where(labels: @filtered_labels).distinct.pluck("dream_id")
    @filtered_dreams = Dream.find(filtered_dreams_id)

    @filtered_dreams = @filtered_dreams.sort_by do |dream|
      if params.dig(:search, :column) == "date"
        dream.dream_date
      else
        dream.significance
      end
    end

    @filtered_dreams = @filtered_dreams.reverse if params.dig(:search, :order) == "desc"

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'labels/partials/filtered_dreams_list.html', locals: { filtered_dreams: @filtered_dreams } }
    end
  end
  
  def new
    @label = current_user.labels.new

    authorize @label
  end

  def create
    @label = Label.new(label_params)
    @label.user = current_user
    authorize @label
    
    if @label.save
      if params[:label][:dream_ids]
        params[:label][:dream_ids].each do |dream_id|
          dream = Dream.find(dream_id)
          DreamLabel.create(label: @label, dream: dream, user: current_user)
        end
      end

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
    
    destroy_dreams = @label.dreams.where.not(id: params[:label][:dream_ids])
    DreamLabel.where(label: @label, dream: destroy_dreams, user: current_user).destroy_all
    
    if @label.update(label_params)
      if params[:label][:dream_ids]
        params[:label][:dream_ids].each do |dream_id|
          dream = Dream.find(dream_id)
          if !DreamLabel.exists?(label: @label, dream: dream, user: current_user)
            DreamLabel.create(label: @label, dream: dream, user: current_user)
          end
        end
      end

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
    params.require(:label).permit(:title, :color, :user_id, :dream_ids)
  end

  def filter_by_label_title
    if params.dig(:search)[:title] == "all"
      @filtered_labels = current_user.labels
    else
      @filtered_labels = Label.where(title: params.dig(:search)[:title], user_id: current_user.id)
    end
  end
end
