require 'spec_helper'

describe GroupMailer do
  let(:csv_file) { File.new("spec/fixtures/examples.csv") }

  before do
    File.any_instance.stub(:original_filename).and_return('examples.csv')
  end

  it "recipient_email" do
    Group.create_yourself(csv_file)
    group = Group.last
    giver = group.users.first
    receiver = group.users.last
    email = GroupMailer.recipient_email(giver, receiver).deliver
    assert !ActionMailer::Base.deliveries.empty?
    expect(email.to).to eq([giver.email])
    expect(email.subject).to eq("Hey #{giver.first_name}, you have a secret santa")
   end
end
