module Api
  module V1
    module Users
      class CafesController < ApplicationController
         skip_before_action :verify_authenticity_token, only: [:create, :update]
        # before_action :set_cafe, only: [:show, :edit, :update, :destroy]

        def index
          @current_cafe = current_user.cafe if current_user&.role == "cafeowner"
          @cafes = Cafe.all
          @orders = Order.where(cafe_id: @current_cafe.id) if @current_cafe.present?
        end

        def show
          @cafe = Cafe.find(params[:id])
          @menus = Menu.where(cafe_id: @cafe.id)
          @orders = @cafe.orders
        end

        def new
          @cafe = Cafe.new
        end


           def create
              @cafe = Cafe.new(cafe_params)
              if @cafe.save
                render json: { cafe: @cafe, message: 'Cafe was successfully created.' }, status: :created
              else
                render json: { errors: @cafe.errors.full_messages }, status: :unprocessable_entity
              end
            end


        def edit
          @cafe = Cafe.find(params[:id])
        end

        def update
          @cafe = Cafe.find(params[:id])
          if @cafe.update(cafe_params)
            redirect_to @cafe, notice: 'Cafe was successfully updated.'
          else
            render :edit
          end
        end

        def destroy
          @cafe = Cafe.find(params[:id])
          @cafe.destroy
          redirect_to cafes_path, notice: 'Cafe was successfully destroyed.'
        end

        private

        def set_cafe
          @cafe = Cafe.find(params[:id])
        end

        def cafe_params
          params.require(:cafe).permit(:name, :city, :address, :phone, :pin_code, :email, :password, :password_confirmation, :image)
        end
      end
    end
  end
end

