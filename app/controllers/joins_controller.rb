class JoinsController < ApplicationController
  before_action :require_login
  def create
    join = Join.new(joins_params)
    join.save
    redirect_to '/events'
  end
  def cancel
    join = Join.where(joins_params)
    join.last.destroy
    redirect_to '/events'
  end
  private
  def joins_params
      params.permit(:user_id, :event_id)
  end
end
