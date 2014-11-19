require 'spec_helper'

describe Group do
  context '#create_yourself' do
    let(:csv_file) { File.new("spec/fixtures/examples.csv") }
    let(:group)    { Group.last }

    before do
      File.any_instance.stub(:original_filename).and_return('examples.csv')
      Group.create_yourself(csv_file)
    end

    it "creates a group with the right number of users and pairs" do
      expect(group.users.count).to eq(5)
      expect(group.pairs.count).to eq(5)
    end

    it "has pairs that never have the same user as giver & recipient" do
      group.pairs.each do |pair|
        expect(pair.giver_id).to_not eq(pair.receiver_id)
      end
    end

    it "never uses the same receiver_id twice" do
      expect(group.pairs.map(&:receiver_id).uniq.count).to eq(group.users.count)
    end

    it "excludes the verboten people" do
      group.pairs.each do |pair|
        expect( User.find(pair.giver_id).forbidden_people ).to_not include(User.find(pair.receiver_id))
      end
    end

  end
end
