require 'active_support/concern'

class PoemsController < ApplicationController
  before_action :set_ids
  skip_before_action :verify_authenticity_token

  # Page Response系
  def popular_page

  end

  def show

  end

  def show_by_signed_in

  end

  def show_by_non_signed_in

  end

  # API系
  def popular

  end

  def popular_by_signed_in

  end

  def popular_by_non_signed_in

  end

  def index

  end

  def index_of
    if cookies[:count_of_user_detail].nil? || cookies[:before_user_id] != @user_id
      cookies[:count_of_user_detail] = 1
    end

    cookies[:before_user_id] = @user_id

    render json: Poem.index_of_user_with_count(
        cookies[:count_of_user_detail].to_i,
        @user_id
               ) and (cookies[:count_of_user_detail] = cookies[:count_of_user_detail].to_i + 1)
  end

  def create
    @contents = params[:contents]

    if @contents.nil? || @contents.empty?
      render json: {
          message: 'You\'re request has not a contents.'
      }, status:   :bad_request and return
    end

    unless current_user.userid == @user_id
      render json: {
          message: 'Sorry. userid is not matched with userid in session'
      }, status:   :bad_request and return
    end

    poem = Poem.new(content: @contents,
                    user_id: current_user.userid,
                    poem_id: PoemUtil.create_poem_id)

    until poem.save
      poem = Poem.new(content: @contents,
                      user_id: current_user.userid,
                      poem_id: PoemUtil.create_poem_id)
    end

    render json: {
        contents: @contents,
        userid:   current_user.userid
    }, status:   :ok and return
  end

  def delete
    unless current_user.userid == @user_id
      render json: {
          message: 'Sorry, You\'re user ID has not matched on request'
      }, status:   :bad_request and return
    end

    poem = Poem.where('poem_id = ?', @poem_id)

    if poem.delete(poem.ids) > 0
      redirect_to root_path
    else
      render json: {
          message: 'You\'re request has failed'
      }, status:   :bad_request and return
    end
  end

  def add_reaction

  end

  private

  def set_ids
    @user_id = params['user_id']
    @poem_id = params['poem_id']
  end
end
