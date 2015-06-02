require_relative "../spec_helper"

describe Item do
  describe "model associations", { item_associations: true } do
    it "returns bids it has received" do
      bids = [FactoryGirl.build(:bid), FactoryGirl.build(:bid)]
      item = FactoryGirl.build(:item, { bids: bids})

      expect(item.bids).to match_array(bids)
    end
  end
end
