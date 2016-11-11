require 'test_helper'
require 'place_bid'

class PlaceBidTest < MiniTest::Test

  def test_it_places_a_bid
    user = User.create!(email: 'santoson17@gmail.com', password: 'password')
    another_user = User.create!(email: 'another_mail@gmail.com', password: 'password')
    product = Product.create!(user_id: user.id, name: 'Some product')
    auction = Auction.create!(product_id: product.id, value: 10)

    service = PlaceBid.new(value: 11, user_id: another_user.id, auction_id: auction.id)

    service.execute

    assert_equal(11, auction.current_bid)
  end
end