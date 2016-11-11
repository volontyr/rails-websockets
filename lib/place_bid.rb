class PlaceBid

  def initialize(options)
    @value = options[:value].to_f
    @user_id = options[:user_id].to_i
    @auction_id = options[:auction_id].to_i
  end

  def execute
    auction = Auction.find(@auction_id)
    bid = auction.bids.build(value: @value, user_id: @user_id)

    if bid.save
      true
    end
  end
end