class ContactsController < ApplicationController
  before_action :set_contact

  def update
    return redirect_to contact_path(@contact), notice: 'Notes cannot be empty.' if
      contact_params[:notes].nil? || contact_params[:notes].empty?
    return redirect_to contact_path(@contact), notice: 'Notes saved.' if
      @contact.update(contact_params)
  end

  def show
    @contact_info = @contact.data
  end

  private
    def contact_params
      params.require(:contact).permit(:notes)
    end

    def set_contact
      @contact = Contact.find_by_id(params[:id])
    end
end
