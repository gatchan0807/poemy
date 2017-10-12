class UsersController < ApplicationController
  before_action :set_id

  def show
  end

  def following
  end

  def follower
  end

  private

  def set_id
    @id = params['user_id']
  end
end
