require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nickname,email,password,password_confirmation,last_name,first_name,last_name_kana,first_name_kana,birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓）を入力してください")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名）を入力してください")
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓）を入力してください")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名）を入力してください")
      end
      it "birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Alphanumeric.alphanumeric(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456a'
        @user.password_confirmation = '123456b'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'aaaaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '11111111'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordに全角英字が含まれると登録できない' do
        @user.password = '111111aA'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'last_nameに英字が含まれると登録できない' do
        @user.last_name = '山田a'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓）は不正な値です')
      end
      it 'first_nameに英字が含まれると登録できない' do
        @user.first_name = 'メアリーじゅんb'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名）は不正な値です')
      end
      it 'last_name_kanaに英字が含まれると登録できない' do
        @user.last_name_kana = 'ヤマダa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓）は不正な値です')
      end
      it 'last_name_kanaにひらがなが含まれると登録できない' do
        @user.last_name_kana = 'ヤマダあ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓）は不正な値です')
      end
      it 'last_name_kanaに漢字が含まれると登録できない' do
        @user.last_name_kana = 'ヤマダ山'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓）は不正な値です')
      end
      it 'last_name_kanaに半角カナが含まれると登録できない' do
        @user.last_name_kana = 'ヤマダｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓）は不正な値です')
      end
      it 'first_name_kanaに英字が含まれると登録できない' do
        @user.first_name_kana = 'メアリージュンa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名）は不正な値です')
      end
      it 'first_name_kanaにひらがなが含まれると登録できない' do
        @user.first_name_kana = 'メアリージュンあ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名）は不正な値です')
      end
      it 'first_name_kanaに漢字が含まれると登録できない' do
        @user.first_name_kana = 'メアリージュン山'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名）は不正な値です')
      end
      it 'first_name_kanaに半角カナが含まれると登録できない' do
        @user.first_name_kana = 'メアリージュンｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名）は不正な値です')
      end
    end
  end
end
