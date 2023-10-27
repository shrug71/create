module Api
  module V1
    module Users
    class OrdersController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:create,:update,:destroy]
      before_action :authenticate_user!
      before_action :set_order, only: [:show, :destroy, :accept, :reject, :confirm, :cancel]

      def index
        @orders = if current_user.role == "cafeowner"
                    current_user.cafe.orders
                  elsif current_user.role == "customer"
                    current_user.orders
                  else
                    Order.all
                  end
        render json: @orders
      end

      def create
        byebug
        @order = Order.new(order_params)
        @user_id = current_user.id
        @order.user_id = @user_id

        if @order.save
          OrderMailer.order_confirmation(@order).deliver_now
          render json: @order, status: :created
        else
          render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
        end
      end

       def update
          @order = Order.find(params[:id])

          if @order.update(order_params)
            render json: @order, status: :ok
          else
            render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
          end
        end
      def show
        render json: @order
      end

      # Rest of the actions (accept, reject, cancel, destroy) go here

      private

      def set_order
        @order = Order.find(params[:id])
      end

      def order_params
        params.require(:order).permit(
          :status,
          :cafe_id,
          menus_attributes: [:status, :menu_id, :quantity, :subtotal, :total]
        )
      end
    end
  end
end
end