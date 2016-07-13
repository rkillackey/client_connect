class ContactsController < ApplicationController

  def update
    contact = Contact.find_by_id(params[:id])

    return redirect_to call_path(contact: contact.id), notice: 'Notes cannot be empty.' if
      contact_params[:notes].nil? || contact_params[:notes].empty?
    return redirect_to call_path(contact: contact.id), notice: 'Notes saved.' if
      contact.update(contact_params)
  end

  private
    def contact_params
      params.require(:contact).permit(:notes)
    end
end
