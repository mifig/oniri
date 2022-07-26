class ExportsController < ApplicationController
  # after_action :verify_policy_scoped, only: [:export], unless: :skip_pundit?
  def export
    skip_authorization

    @dreams = Dream.where(user: current_user).order(:dream_date)
    @dream_headers = Dream.column_names
    
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"dreams-#{Date.today}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end
end
