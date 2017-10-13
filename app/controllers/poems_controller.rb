class PoemsController < ApplicationController
  before_action :set_ids

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
