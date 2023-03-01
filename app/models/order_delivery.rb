class OrderDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postcode, :prefecture_id, :city, :block, :building, :phone

  with_options presence: true do
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000, message: "is invalid"}
    validates :item_id
    validates :user_id
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :block
    validates :phone, format: {with: /\A\d{10,11}\z/ }
  end
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(item_id, :item_id, user_id: user_id)
    Delivery.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone: phone, order_id: order.id)
  end
end