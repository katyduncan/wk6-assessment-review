require_relative "../spec_helper"

describe User do
  describe "model associations", { user_associations: true } do
    before(:each) do
      @mystical_item = FactoryGirl.create(:item, description: "Dragon's Tears")
      @evil_mystical_item = FactoryGirl.create(:item, description: "Wolfsbane")
      @algernon = FactoryGirl.create(:bidder)
      @mystical_bids = [
        FactoryGirl.create(:bid, { bidder: @algernon, item: @mystical_item }),
        FactoryGirl.create(:bid, { bidder: @algernon, item: @evil_mystical_item })
      ]
    end

    it "returns the bids that the user has made" do
      expect(@algernon.bids).to match_array @mystical_bids
    end

    it "returns items on which the user has placed a bid" do
      expect(@algernon.items).to match_array [@mystical_item, @evil_mystical_item]
    end

    it "returns items which the user has created" do
      item1 = FactoryGirl.create(:item, description: "Algernon's Item 1")
      item2 = FactoryGirl.create(:item, description: "Algernon's Item 2")
      @algernon.items << item1
      @algernon.items << item2
      expect(@algernon.posted_items).to match_array [item1, item2]
    end
  end

  describe "additional model behaviors", { user_behaviors: true } do
    before(:each) do
      @tessie = FactoryGirl.create(:user_with_fake_password)
      @item1 = FactoryGirl.create(:item)
      @item2 = FactoryGirl.create(:item)
      @item3 = FactoryGirl.create(:item)
      @bid1 = Bid.create(bidder: @tessie, amount: 100, item: @item1)
      @bid2 = Bid.create(bidder: @tessie, amount: 50,  item: @item2)
      @bid3 = Bid.create(bidder: @tessie, amount: 50,  item: @item3)
    end

    describe "#total bids placed" do
      it "returns the total of all the items the user has bid on" do
        expect(@tessie.total_bids).to eq 200.00
      end
    end
  end

  describe "validations", { user_validations: true } do
    it "must have a username" do
      godfrey = FactoryGirl.build(:user)
      expect(godfrey).to be_valid

      godfrey.username = nil
      expect(godfrey).to_not be_valid
    end

    it "must have a unique username" do
      davey = FactoryGirl.create(:user_with_fake_password, { username: "davey" })
      second_davey = build(:user, { username: "davey" })
      expect(second_davey).to_not be_valid

      second_davey.username = "official_davey"
      expect(second_davey).to be_valid
    end
  end
end
