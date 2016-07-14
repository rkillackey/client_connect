class AddVoicemailLinkToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :voicemail_link, :string
  end
end
