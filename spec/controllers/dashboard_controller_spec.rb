require 'rails_helper'

RSpec.describe DashboardController do
  describe 'GET #index' do
    it 'shows all contact leads' do
      contact = double('Contact')
      allow(Contact).to receive(:order) { contact }
      allow(contact).to receive(:limit).with(5) { [contact] }

      get :index
      expect(assigns :contacts).to eq([contact])
    end
  end
end
