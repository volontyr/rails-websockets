require 'test_helper'
require 'place_bid'

class PlaceBidTest < MiniTest::Test

  def setup
    @user = User.create!(email: 'santoson17@gmail.com', password: 'password')
    @another_user = User.create!(email: 'another_mail@gmail.com', password: 'password')
    @product = Product.create!(user_id: user.id, name: 'Some product')
    @auction = Auction.create!(product_id: product.id, value: 10, end_at: (Time.now + 24.hours))
  end

  def test_it_places_a_bid
    service = PlaceBid.new(value: 11, user_id: another_user.id, auction_id: auction.id)
    service.execute

    assert_equal(11, auction.current_bid)
  end

  def test_fails_if_a_bid_under_current_bid
    service = PlaceBid.new(value: 9, user_id: another_user.id, auction_id: auction.id)

    refute service.execute, 'Should not place a bid'
  end

  def test_notifies_if_auction_ended
    service = PlaceBid.new(value: 12, user_id: another_user.id, auction_id: auction.id)
    service.execute

    another_service = PlaceBid.new(value: 900, user_id: another_user.id, auction_id: auction.id)
    Timecop.travel(Time.now + 25.hours)
    another_service.execute

    assert_equal :won, another_service.status
  end

  private
    attr_reader :user, :another_user, :product, :auction
end