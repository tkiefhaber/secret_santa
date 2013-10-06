require 'spec_helper'
describe GroupsController do
  describe "POST create" do
    context 'csv_file is uploaded' do
      let(:csv_file) { fixture_file_upload("examples.csv", 'text/csv') }

      before do
        Group.should_receive(:create_yourself).with(csv_file)
        post :create, :group => {:file => csv_file}
      end

      it "redirects with a flash message" do
        expect(response).to redirect_to(new_group_path)
        expect(flash[:notice]).to eq("emails will go out to participants shortly")
      end
    end
  end
end
