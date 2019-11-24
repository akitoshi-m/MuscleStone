require 'rails_helper'

RSpec.describe User, type: :model do
  # describe '#age' do
  #   context '20年前の生年月日の場合' do
  #     let(:user) { User.new(birthday: Time.zone.now - 20.years) }
      
  #     it '年齢が20歳であること' do
  #       expect(user.age).to eq 20
  #     end
  #   end
  # end
  
  context 'ユーザー登録' do
    it 'ユーザー名とメールアドレス、passwordが登録に必要' do
      user = User.create(
        name:     'ゲストユーザー',
        email:    'guest@guest.com',
        password: 'password12'
      )
      expect(user).to be_valid
    end
  end
  
  context 'ユーザー登録ができない場合' do
    it 'ユーザー名が未入力' do
      user = User.new(name: nil)
      expect(user.valid?).to eq(false)
    end

    it 'ユーザー名が11文字以上' do
      user = User.create(
        name:     'ゲストユーザー****',
        email:    'guest@guest.com',
        password: 'password12'
        )
      expect(user).not_to be_valid
    end
    
    it 'メールアドレスが未入力' do
      user = User.new(email: nil)
      expect(user.valid?).to eq(false)
    end
    
    it 'emailの形式が**@**.comの形式になっていない為エラーになる' do
      user = User.create(
        name:     'ゲストユーザー',
        email:    'guest@com',
        password: 'password12'
      )
      expect(user).not_to be_valid
    end
    
    it 'パスワードが未入力' do
      user = User.new(password: nil)
      expect(user.valid?).to eq(false)
    end
    
    it 'パスワードにローマ字と数字が入っていない為エラーとなる' do
      user = User.create(
        name:     'ゲストユーザー',
        email:    'guest@guest.com',
        password: 'password'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードが7文字以下のためエラーとなる' do
      user = User.create(
        name:     'ゲストユーザー',
        email:    'guest@guest.com',
        password: 'pass12'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードが33文字以上の為エラーとなる' do
      user = User.create(
        name:     'ゲストユーザー',
        email:    'guest@guest.com',
        password: 'password12password12password12password12'
      )
      expect(user).not_to be_valid
    end
  end
end