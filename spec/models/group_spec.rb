require 'spec_helper'

describe Group do
  context '#create_yourself' do
    let(:csv_file) { File.new("spec/fixtures/examples.csv") }

    before do
      File.any_instance.stub(:original_filename).and_return('examples.csv')
    end

    it "creates a group with the right number of users and pairs" do
      Group.create_yourself(csv_file)
      group = Group.last
      expect(group.users.count).to eq(4)
      expect(group.pairs.count).to eq(4)
    end

    it "has pairs that never have the same user as giver & recipient" do
      Group.create_yourself(csv_file)
      group = Group.last
      group.pairs.each do |pair|
        expect(pair.giver_id).to_not eq(pair.receiver_id)
      end
    end

    it "never uses the same receiver_id twice" do
      Group.create_yourself(csv_file)
      group = Group.last
      expect(group.pairs.map(&:receiver_id).uniq.count).to eq(group.users.count)
    end

  end
end
