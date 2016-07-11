class DashboardController < ApplicationController
  def index
    @contacts = Contact.order('time_contacted DESC').limit(5)
  end

  def call
    @contact = Contact.find_by_id(params[:contact])
    @phone_number = @contact.data['From']
  end
end
