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
    if user_signed_in?
      popular_by_signed_in
    else
      popular_by_non_signed_in
    end
  end

  def popular_by_signed_in
    if session[:counter_for_popular].nil?
      session[:counter_for_popular] = 1
    end

    render json:
               Poem.index_by_popular(
                   session[:counter_for_popular].to_i
               ) and (session[:counter_for_popular] = session[:counter_for_popular].to_i + 1)
  end

  def popular_by_non_signed_in
    if session[:counter_for_popular].nil?
      session[:counter_for_popular] = 1
    end

    raw = Poem.index_by_popular(session[:counter_for_popular].to_i)

    concealed = raw.map { |poem|
      Formatter.index_popular_for_dis_signed_in(poem)
    }

    render json: concealed and (session[:counter_for_popular] = session[:counter_for_popular].to_i + 1)
  end

  def index
    if session[:counter_for_top].nil?
      session[:counter_for_top] = 1
    end

    # 'SELECT poems.* FROM poems WHERE user_id IN(SELECT followed_id FROM follows WHERE follow_id = \'ahaha0807_alg\')'
    user_id = Follow.where('follow_id = ?', current_user.userid).select(:followed_id)
    poems   = Poem.where(user_id: user_id).limit(20 * session[:counter_for_top].to_i)

    render json: poems and (session[:counter_for_top] = session[:counter_for_top].to_i + 1)
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
    unless user_signed_in?
      render json: {
          message: 'You need sign_in or sign_up.'
      }, status:   :unauthorized and return
    end

    if session[:reacted].nil?
      session[:reacted] = Array.new
    end

    if PoemUtil.is_reacted(@poem_id, session[:reacted])
      render json: {
          message: 'Already you are reacted'
      }, status:   :bad_request and return
    end

    @reaction_type = params[:reaction_type]

    if Poem.add_reaction(@poem_id, @reaction_type)
      session[:reacted].push(@poem_id)
      render json: {
          message: 'Successfully to add reaction.'
      }, status:   :ok and return
    else
      render json: {
          message: 'Failed to add reaction.'
      }, status:   :bad_request and return
    end
  end

  private

  def set_ids
    @user_id = params['user_id']
    @poem_id = params['poem_id']
  end
end
