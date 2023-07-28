require "test_helper"

class Api::V1::ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "Create Airbnb reservation" do
    assert_difference(
      ->{ Guest.count } => 1,
      ->{ Reservation.count } => 1,
      ->{ PhoneNumber.count } => 1
    ) do
      params = JSON.parse file_fixture('airbnb_1.json').read
      post api_v1_reservations_upsert_url, params: params, as: :json
      assert_response :success
      assert_equal '{"success":true}', @response.body
    end
  end

  test "Create Booking.com reservation" do
    assert_difference(
      ->{ Guest.count } => 1,
      ->{ Reservation.count } => 1,
      ->{ PhoneNumber.count } => 2
    ) do
      params = JSON.parse file_fixture('bookingdotcom_1.json').read
      post api_v1_reservations_upsert_url, params: params, as: :json
      assert_response :success
      assert_equal '{"success":true}', @response.body
    end
  end

  test "Two reservations, one guest" do
    params = JSON.parse file_fixture('bookingdotcom_1.json').read
    post api_v1_reservations_upsert_url, params: params, as: :json

    assert_difference(
      ->{ Guest.count } => 0,
      ->{ Reservation.count } => 1,
      ->{ PhoneNumber.count } => 1,
    ) do
      params = JSON.parse file_fixture('bookingdotcom_2.json').read
      post api_v1_reservations_upsert_url, params: params, as: :json
      assert_response :success
      assert_equal '{"success":true}', @response.body
    end
  end

  test "Update reservation status" do
    params = JSON.parse file_fixture('bookingdotcom_1.json').read
    post api_v1_reservations_upsert_url, params: params, as: :json

    assert_difference(
      ->{ Guest.count } => 0,
      ->{ Reservation.count } => 0,
      ->{ PhoneNumber.count } => 0,
      ->{ Reservation.where(status: 'cancelled').count } => 1,
    ) do
      params = JSON.parse file_fixture('bookingdotcom_3.json').read
      post api_v1_reservations_upsert_url, params: params, as: :json
      assert_response :success
      assert_equal '{"success":true}', @response.body
    end
  end

  test "Invalid JSON" do
    assert_no_difference([
      ->{ Guest.count },
      ->{ Reservation.count },
      ->{ PhoneNumber.count }
    ]) do
      params = JSON.parse file_fixture('invalid_1.json').read
      post api_v1_reservations_upsert_url, params: params, as: :json
      assert_response :bad_request
      assert_equal '{"success":false}', @response.body
    end

    assert_no_difference([
      ->{ Guest.count },
      ->{ Reservation.count },
      ->{ PhoneNumber.count }
    ]) do
      params = JSON.parse file_fixture('invalid_2.json').read
      post api_v1_reservations_upsert_url, params: params, as: :json
      assert_response :bad_request
      assert_equal '{"success":false}', @response.body
    end
  end

end
