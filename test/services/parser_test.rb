require "test_helper"

class ParserTest < ActiveSupport::TestCase
  test "Correctly identify Airbnb" do
    params = JSON.parse file_fixture('airbnb_1.json').read
    klass = PayloadParser.identify_payload(params)
    assert_equal Airbnb, klass
  end

  test "Correctly identify Booking.com" do
    params = JSON.parse file_fixture('bookingdotcom_1.json').read
    klass = PayloadParser.identify_payload(params)
    assert_equal BookingDotCom, klass
  end

  test "Reject invalid JSON" do
    params = JSON.parse file_fixture('invalid_1.json').read
    klass = PayloadParser.identify_payload(params)
    assert_nil klass
  end

  test "Reject invalid JSON with exception" do
    params = JSON.parse file_fixture('invalid_2.json').read
    assert_raises RuntimeError do
      PayloadParser.identify_payload!(params)
    end
  end

end
