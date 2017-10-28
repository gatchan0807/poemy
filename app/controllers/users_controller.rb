class UsersController < ApplicationController
  before_action :set_ids
  skip_before_action :verify_authenticity_token

  def show
  end

  def following
  end

  def follower
  end

  def follow
    unless Follow.where('follow_id = ? AND followed_id = ?', current_user.userid, @id).empty?
      render json: { message: 'Already you followed.' } and return
    end

    follow = Follow.new(follow_id: current_user.userid, followed_id: @id)

    if follow.save
      render json: { message: 'Follow was complete.' } and return
    else
      render json: { message: 'Follow was failed' }, status: :bad_request and return
    end
  end

  private

  def set_ids
    @id = params['user_id']
  end
end
