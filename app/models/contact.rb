class Contact < ActiveRecord::Base
  validates_presence_of :time_contacted, :data
end
