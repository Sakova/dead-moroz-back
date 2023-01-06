class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :allow_access?

  def index
    users = User.all.order(:id).page params[:page]
    render json: users, status: :ok
  end

  def translate
    result = Rails.cache.fetch("user/#{params[:user]}", expires_in: 1.day) do
      user = User.find(params[:user])
      gifts = user.gifts.map{|gift| gift.description}.join("___")

      translated_gifts = ProfileTranslate.translate(gifts)
      translated_items = ProfileTranslate.translate(user.items.join("___"))

      {items: translated_items, gifts: translated_gifts}
    end

    render json: result, status: :ok
  end
end
