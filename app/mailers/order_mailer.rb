class OrderMailer < ApplicationMailer
  #def order_confirmation(order)
    #@order = order
    #mail(to: 'purohit.shruti01@gmail.com', subject: 'Order Confirmation')
  #end
#end


  def order_confirmation(order)
    @order = order
    mail(to: @order.user.email, subject: 'Order Confirmation')
  end

  def cafe_order_confirmation(email, order)
    @order = order
    mail(to: email, subject: 'Cafe Order Confirmation')
  end

  def cafe_order_cancellation(email, order)
    @order = order
    mail(to: email, subject: 'Cafe Order Cancellation')
  end

  def customer_order_accepted(email, order)
    @order = order
    mail(to: email, subject: 'Order Accepted')
  end

  def customer_order_rejected(email, order)
    @order = order
    mail(to: email, subject: 'Order Rejected')
  end
end
