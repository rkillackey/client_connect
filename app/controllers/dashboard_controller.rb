class DashboardController < ApplicationController
  def index
    @contacts = Contact.order('time_contacted DESC').limit(5)
  end
end
