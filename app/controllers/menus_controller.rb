module Api
  module V1
     module Users
    class MenusController < ApplicationController
      before_action :set_menu, only: [:show, :update, :destroy]
      before_action :set_cafe, only: [:index]

      def index
        @menus = Menu.all
        @cafe = current_user.cafe if current_user&.role == "cafeowner"
        @menus = @cafe.menus if @cafe.present?
        render json: @menus
      end

      def show
        if @menu && @cafe
          # Use @cafe.name to display the cafe's name
          render json: { menu: @menu, cafe_name: @cafe.name }
        else
          render json: { error: 'Menu not found or associated cafe not found.' }, status: :not_found
        end
      end

      def create
        @menu = Menu.new(menu_params)

        if @menu.save
          render json: @menu, status: :created
        else
          render json: { errors: @menu.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @menu.update(menu_params)
          render json: { message: 'Menu was successfully updated.' }
        else
          render json: { errors: @menu.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @menu
          @menu.destroy
          render json: { message: 'Menu was successfully destroyed.' }
        else
          render json: { error: 'Menu not found.' }, status: :not_found
        end
      end

      private

      def set_menu
        @menu = Menu.find_by(id: params[:id])
        @cafe = @menu&.cafe
      end

      def set_cafe
        @cafe = Cafe.find_by(id: params[:cafe_id])
      end

      def menu_params
        params.require(:menu).permit(:name, :price, :quantity, :cafe_id)
      end
    end
  end
end
end

