require "spec_helper"

describe Contact do
  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :phone }
  end

  describe ".to_csv" do
    let!(:contact_1) { create(:contact, name: "John Tan", phone: "12346578") }
    let!(:contact_2) { create(:contact, name: "Wynn Tay", phone: "87654321") }

    it "returns tab-delimited CSV for all contacts" do
      generated_csv = Contact.to_csv
      expected_csv  = File.read("#{Rails.root}/spec/fixtures/contacts.csv")

      expect(generated_csv).to eq expected_csv
    end
  end
end
