require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivery).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_delivery.building = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できないこと' do
        @order_delivery.postcode = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_delivery.postcode = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("都道府県は1以外の値にしてください")
      end
      it 'cityが空だと保存できないこと' do
        @order_delivery.city = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'blockが空だと保存できないこと' do
        @order_delivery.block = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("番地を入力してください")
      end
      it 'phoneが空だと保存できないこと' do
        @order_delivery.phone = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phoneが半角のハイフンを含んだ形式では保存できないこと' do
        @order_delivery.phone = '111-1111-1111'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phoneが全角数字だと保存できないこと' do
        @order_delivery.phone = '１１１１１１１１１１１'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'phoneが9桁以下だと保存できないこと' do
        @order_delivery.phone = '111111111'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'phoneが12桁以上だと保存できないこと' do
        @order_delivery.phone = '111111111111'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Itemを入力してください")
      end
      it "tokenが空では登録できないこと" do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("カード情報を入力してください")
      end
    end
  end
end
