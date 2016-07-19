require 'rails_helper'

describe Contact, type: :model do
  subject { build(:contact) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :time_contacted }
  it { is_expected.to validate_presence_of :data }
end
