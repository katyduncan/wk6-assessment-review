require_relative "../spec_helper"

describe Bid do
  describe "model associations", { bid_associations: true } do
    it "returns the user who placed the bid" do
      erma = FactoryGirl.build(:bidder)
      bid = FactoryGirl.build(:bid, { bidder: erma })

      expect(bid.bidder).to eq erma
    end
  end

  describe ".highest" do
    it "resolves the highest bid", { bid_behaviors: true} do
      bidder = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item)
      highest = FactoryGirl.create(:bid, amount: 100, bidder_id: bidder.id, item_id: item.id)
      lowest = FactoryGirl.create(:bid, amount: 1, bidder_id: bidder.id, item_id: item.id)

      expect(Bid.highest).to eq highest

    end
  end

  describe ".highest_bidder", { bid_behaviors: true} do
    it "resolves the highest bidder" do
      bidder = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item)
      highest = FactoryGirl.create(:bid, amount: 100, bidder_id: bidder.id, item_id: item.id)
      lowest = FactoryGirl.create(:bid, amount: 1, bidder_id: bidder.id, item_id: item.id)

      expect(Bid.highest_bidder).to eq bidder

    end
  end

  describe "validations", { bid_validations: true } do
    it "must have a positive amount" do
      bidder = FactoryGirl.build(:user)
      item = FactoryGirl.build(:item)
      bid = FactoryGirl.build(:bid, bidder_id: bidder.id, item_id: item.id, amount: -200.00)

      expect(bid).to_not be_valid
    end
  end
end
