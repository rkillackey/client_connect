class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.datetime :time_contacted
      t.jsonb :data
      t.text :notes
      t.timestamps null: false
    end
  end
end
