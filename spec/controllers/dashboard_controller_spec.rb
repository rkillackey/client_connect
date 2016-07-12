require 'rails_helper'

RSpec.describe DashboardController do
  describe '#index' do
    it 'assigns tickets' do
      contact = double('Contact')
      allow(Contact).to receive(:all) { [contact] }

      get :index
      expect(assigns :contacts).to eq([contact])
    end
  end
end
