class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new
  end

  def create
  end
end
