class CafeMenusController < ApplicationController
  def new
    @cafe_menu = CafeMenu.new
  end

  def create
    @cafe_menu = CafeMenu.new(cafe_menu_params)
    if @cafe_menu.save
      redirect_to cafe_menus_path, notice: 'Cafe menu item was successfully created.'
    else
      render :new
    end
  end

  def index
    @cafe_menus = CafeMenu.all
  end

  # Define other actions as needed (e.g., show, edit, update, destroy)

  private

  def cafe_menu_params
    params.require(:cafe_menu).permit(:cafe_id, :menu_id)
  end
end
