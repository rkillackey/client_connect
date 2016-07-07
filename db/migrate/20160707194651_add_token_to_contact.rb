class AddTokenToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :token, :string
  end
end
