require 'rails_helper'

describe UrlsController do

  describe 'GET #index' do
    context 'unlogged user' do
      it 'redirects to login page' do
        get :index
        expect(subject).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'unlogged user' do
      context 'valid URL' do
        it "returns http success" do
          post :create, url: attributes_for(:url)
          expect(response).to redirect_to(new_url_path)
        end
      end
    end

    context 'logged user' do
      before(:each) { sign_in create(:user) }

      context 'valid url' do
        it "returns http success" do
          post :create, url: attributes_for(:url)
          expect(response).to redirect_to(urls_path)
        end

        it "saves the url" do
          expect { post :create, url: attributes_for(:url) }.to change(Url, :count).by(1)
        end
      end
    end
  end

  describe "DELETE destroy" do
    let(:url) { create(:url) }
    let(:user) { create(:user) }

    context "unlogged user" do
      it "redirects to login page" do
        delete :destroy, id: url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "logged user" do
      before(:each) do
        sign_in user
        url.user = user
        url.save!
      end

      it "deletes URL" do
        expect { delete :destroy, id: url }.to change(Url, :count).by(-1)
      end

      it "redirects to index" do
        delete :destroy, id: url
        expect(response).to redirect_to(urls_path)
      end
    end
  end
end
