require 'rails_helper'

RSpec.describe ContactsController do
  let!(:contact) { create(:contact) }

  describe 'PUT #update' do
    context 'valid attributes' do
      it "updates the contact's attributes" do
        put :update, params: { id: contact, contact: attributes_for(:contact, notes: 'Test notes') }
        contact.reload
        expect(contact.notes).to eq('Test notes')
      end

      it 'redirects to the updated contact' do
        put :update, params: { id: contact, contact: attributes_for(:contact, notes: 'Test notes') }
        expect(response).to redirect_to contact
      end
    end

    context 'invalid attributes' do
      it "does not change the contact's attributes" do
        put :update, params: { id: contact, contact: attributes_for(:contact, notes: '') }
        expect(response).to_not eq('')
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested contact to @contact' do
      get :show, params: { id: contact }
      expect(assigns(:contact)).to eq(contact)
    end

    it 'renders the show template' do
      get :show, params: { id: contact }
      expect(response).to render_template("show")
    end
  end
end
