require 'active_support/concern'

class PoemsController < ApplicationController
  before_action :set_ids
  skip_before_action :verify_authenticity_token

  # Page Response系
  def popular_page

  end

  def show

  end

  # API系
  def popular

  end

  def index

  end

  def index_of

  end

  def create
    if params[:contents].nil? || params[:contents].empty?
      render json: { message: 'You\'re request has not a contents.' }, status: :bad_request and return
    end

    unless params[:user_id] == current_user.userid
      render json: {
          message: 'Sorry. userid is not matched with userid in session'
      }, status:   :bad_request and return
    end

    poem = Poem.new(content: params[:contents], user_id: current_user.userid, poem_id: PoemUtil.create_poem_id)

    until poem.save
      poem = Poem.new(content: params[:contents], user_id: current_user.userid, poem_id: PoemUtil.create_poem_id)
    end

    render json: {
        contents: params[:contents],
        userid:   current_user.userid
    }, status:   :ok and return
  end

  def delete

  end

  def add_reaction

  end

  private

  def set_ids
    @user_id = params['user_id']
    @poem_id = params['poem_id']
  end
end
