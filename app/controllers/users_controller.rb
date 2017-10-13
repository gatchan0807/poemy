class UsersController < ApplicationController
  before_action :set_ids

  def show
  end

  def following
  end

  def follower
  end

  private

  def set_ids
    @id = params['user_id']
  end
end
