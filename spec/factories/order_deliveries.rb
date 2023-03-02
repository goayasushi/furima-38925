FactoryBot.define do
  factory :order_delivery do
    postcode { '123-4567' }
    prefecture_id { 1 }
    city { '東京区' }
    block { '1-1' }
    building { '東京ハイツ' }
    phone { 11111111111 }
  end
end
