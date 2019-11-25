require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before { get :new }
    
    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end
    
    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end

    it '新しいuserオブジェクトがビューに渡されること' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    context '正しいユーザー情報が渡ってきた場合' do
      let(:params) do
        { user: {
            name: 'ゲストユーザー',
            email: 'guest@guest.com',
            password: 'password12',
            paddword_confirmation: 'password12',
          }
        }
      end
      
      it 'ユーザーが一人増えていること' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end
    end
  end
end
