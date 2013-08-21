require "spec_helper"

describe ContactsController do
  describe "#create" do
    def do_request
      post :create, contact: params, format: :json
    end

    context "success" do
      let(:params) { attributes_for(:contact) }

      it "creates a new contact" do
        expect { do_request }.to change(Contact, :count).by(1)
      end

      it "returns a json response" do
        do_request
        expect(response.body).to eq Contact.last.to_json
      end
    end

    context "failure" do
      let(:params) { {name: ""} }

      it "doesn't create a new contact" do
        expect { do_request }.to_not change(Contact, :count)
      end

      it "returns an error response" do
        do_request
        expect(response.status).to eq 422
      end
    end
  end

  describe "update" do
    let!(:contact) { create(:contact) }
    let(:old_name) { contact.name }
    let(:new_name) { "#{old_name}-changed" }

    def do_request
      put :update, id: contact.id, contact: params, format: :json
    end

    context "success" do
      let(:params) { {name: new_name} }

      it "updates the existing contact" do
        do_request
        expect(contact.reload.name).to eq new_name
      end

      it "returns an empty json response" do
        do_request
        expect(response.body).to be_empty
      end
    end

    context "failure" do
      let(:params) { {name: ""} }

      it "doesn't update the existing contact" do
        do_request
        expect(contact.reload.name).to eq old_name
      end

      it "returns an error response" do
        do_request
        expect(response.status).to eq 422
      end
    end
  end

  describe "destroy" do
    let!(:contact) { create(:contact) }

    def do_request
      delete :destroy, id: contact.id, format: :json
    end

    it "deletes the contact" do
      expect { do_request }.to change(Contact, :count).by(-1)
    end
  end
end
