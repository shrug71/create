class OrderMenusController < ApplicationController
  def new
    @order_menu = OrderMenu.new
    @menus = Menu.all
  end

 
  def create
    # order_menu_params = params.require(:order_menu).permit(:menu_id, :order_id, :quantity, :subtotal, :total)
    selected_menus = params[:menus_attributes].select{|attr| attr["menu_selected"] == "true"}
    # @order_menu = OrderMenu.new(order_menu_params)
    order = Order.create(user_id: current_user.id, cafe_id: params[:cafe_id]) if selected_menus.present?
    is_order_created = false
    selected_menus.each do |selected_menu|
      if OrderMenu.create(menu_id: selected_menu[:menu_id], order_id: order.id.to_i, quantity: selected_menu[:quantity].to_i)
        is_order_created = true
      end
    end

    if is_order_created
      redirect_to order_menus_path, notice: 'Order menu item was successfully created.'
     else
      render :new
     end
    end


    def index
    @order_menus = OrderMenu.all.includes(:menu)
    end

  # Define other actions as needed (e.g., show, edit, update, destroy)

    private   
 
    def order_menu_params
      params.require(:order_menu).permit(:menu_id, :order_id, :quantity)
    end

end