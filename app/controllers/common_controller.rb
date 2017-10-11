class CommonController < ApplicationController
  def landing
  end

  def non_sign_in
    render html: 'non_sign_in'
  end

  def signed_in
    render html: 'signed_in'
  end

  def about
    render html: 'about'
  end

  def support
    render html: 'support'
  end

  def post_support
    render html: 'post_support'
  end

  def policies
    render html: 'policies'
  end
end
