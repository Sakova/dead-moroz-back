class Api::V1::AddressesController < ApplicationController
  before_action :authenticate_user!

  def create
    address_hash = { **address_params, user_id: current_user.id}
    if current_user.address.present?
      address_hash[:id] = current_user.address.id
    end

    if Address.upsert(address_hash)
      render json: current_user.address, status: :ok
    else
      render json: {message: "address update failed"}, status: :unprocessable_entity
    end
  end

  private

  def address_params
    @addr_params ||= params.permit(:street, :house, :floor)
  end
end