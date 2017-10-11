class CommonController < ApplicationController

  # Page Response系
  def landing
  end

  def non_sign_in
    render html: 'non_sign_in'
  end

  def signed_in
    render html: 'signed_in'
  end

  def about
  end

  def support
  end

  def policies
  end

  # API系
  def post_support
    render html: 'post_support'
  end
end
