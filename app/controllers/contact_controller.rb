class ContactController < ApplicationController

  def create
    Contact.create({
      time_contacted: Time.now,
      data: params[:contact]
    })
  end

end
