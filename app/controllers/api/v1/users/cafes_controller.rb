# app/controllers/api/v1/cafes_controller.rb
module Api
  module V1
    module Users
    class CafesController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:create,:update,:destroy]
      # before_action :set_cafe, only: [:show, :edit, :update, :destroy]

      def index
        @current_cafe = current_user.cafe if current_user&.role == "cafeowner"
        @cafes = Cafe.all
        @orders = Order.where(cafe_id: @current_cafe.id) if @current_cafe.present?

        render json: {
          current_cafe: @current_cafe,
          cafes: @cafes,
          orders: @orders
        }
      end

      #def show
       # @menus = Menu.where(cafe_id: @cafe.id)
       # @orders = @cafe.orders

        #render json: {
         # cafe: @cafe,
         # menus: @menus,
          #orders: @orders
        #}
      #end
      def show
    @cafe = Cafe.find_by(id: params[:id])

    if @cafe
      render json: @cafe, status: :ok
    else
      render json: { error: 'Cafe not found' }, status: :not_found
    end
  end

      def create
        byebug
        @cafe = Cafe.new(cafe_params)
        if @cafe.save
          render json: { cafe: @cafe, message: 'Cafe was successfully created.' }, status: :created
        else
          render json: { errors: @cafe.errors.full_messages }, status: :unprocessable_entity
        end
      end

       def update
    @cafe = Cafe.find(params[:id])  # Ensure @cafe is not nil
    if @cafe.update(cafe_params)
      render json: @cafe, status: :ok
    else
      render json: { errors: @cafe.errors.full_messages }, status: :unprocessable_entity
    end
  end

      def destroy
    @cafe = Cafe.find_by(id: params[:id])

    if @cafe
      @cafe.destroy
      render json: { message: 'Cafe was successfully destroyed.' }, status: :ok
    else
      render json: { error: 'Cafe not found' }, status: :not_found
    end
  end

      private

      def set_cafe
        @cafe = Cafe.find(params[:id])
      end

      def cafe_params
        params.require(:cafe).permit(:name, :city, :address, :phone, :pin_code, :email, :password, :password_confirmation, :image,:user_id)
      end
    end
  end
end
end