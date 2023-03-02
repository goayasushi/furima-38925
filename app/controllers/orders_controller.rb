class OrdersController < ApplicationController
  def index
    @oeder_delivery = OrderDelivery.new
  end

  def create
  end
end
