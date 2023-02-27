require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品投稿' do
    context '商品投稿できる場合' do
      it 'product,contentcategory_id,status_id,charge_id,prefecture_id,preparation_id,price,image,user_idが存在していれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '商品投稿できない場合' do
      it 'productが空では保存できない' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product can't be blank")
      end
      it 'contentが空では保存できない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'categoryが「---」では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'statusが「---」では保存できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end
      it 'chargeが「---」では保存できない' do
        @item.charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge must be other than 1")
      end
      it 'prefectureが「---」では保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'preparationが「---」では保存できない' do
        @item.preparation_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Preparation must be other than 1")
      end
      it 'priceが正の少数では保存できない' do
        @item.price = Faker::Number.between(from: 300.0, to: 9999999.0)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be an integer")
      end
      it 'priceが1以上、299以下の整数では保存できない' do
        @item.price = Faker::Number.between(from: 1, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが0以下では保存できない' do
        @item.price = -1
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが10,000,000以上では保存できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
