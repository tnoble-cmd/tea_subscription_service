require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should belong_to(:customer) }
  it { should belong_to(:tea) }
  it { should define_enum_for(:status).with_values([:active, :cancelled]) }
end