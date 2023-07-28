class BookingDotCom < ParserBase

  def create_entities!
    ActiveRecord::Base.transaction do
      guest = build_guest
      reservation = build_reservation guest
      phone_numbers = build_phone_numbers guest
    end
    true
  end

  private

  def build_guest
    params = payload["reservation"]
    guest = Guest.find_or_initialize_by email: params["guest_email"]
    guest.assign_attributes(
      first_name: params["guest_first_name"],
      last_name: params["guest_last_name"],
    )
    guest.save!
    guest
  end

  def build_reservation(guest)
    params = payload["reservation"]
    reservation = Reservation.find_or_initialize_by code: params["code"]
    reservation.assign_attributes(
      guest: guest,
      start_date: params["start_date"],
      end_date: params["end_date"],
      nights: params["nights"],
      guests: params["number_of_guests"],
      children: params["guest_details"]["number_of_children"],
      adults: params["guest_details"]["number_of_adults"],
      infants: params["guest_details"]["number_of_infants"],
      status: params["status_type"],
      security_price: params["listing_security_price_accurate"],
      payout_price: params["expected_payout_amount"],
      total_price: params["total_paid_amount_accurate"],
      currency: params["host_currency"],
    )
    reservation.save!
    reservation
  end

  def build_phone_numbers(guest)
    params = payload["reservation"]
    params["guest_phone_numbers"].map do |n|
      phone_number = PhoneNumber.find_or_initialize_by guest_id: guest.id, number: n
      phone_number.save!
      phone_number
    end
  end

  SCHEMA = {
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {
      "reservation": {
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "start_date": {
            "type": "string"
          },
          "end_date": {
            "type": "string"
          },
          "expected_payout_amount": {
            "type": "string"
          },
          "guest_details": {
            "type": "object",
            "properties": {
              "localized_description": {
                "type": "string"
              },
              "number_of_adults": {
                "type": "integer",
                "minimum": 0
              },
              "number_of_children": {
                "type": "integer",
                "minimum": 0
              },
              "number_of_infants": {
                "type": "integer",
                "minimum": 0
              }
            },
            "required": [
              "localized_description",
              "number_of_adults",
              "number_of_children",
              "number_of_infants"
            ]
          },
          "guest_email": {
            "type": "string"
          },
          "guest_first_name": {
            "type": "string"
          },
          "guest_last_name": {
            "type": "string"
          },
          "guest_phone_numbers": {
            "type": "array",
            "items": [
              {
                "type": "string"
              },
              {
                "type": "string"
              }
            ]
          },
          "listing_security_price_accurate": {
            "type": "string"
          },
          "host_currency": {
            "type": "string"
          },
          "nights": {
            "type": "integer",
            "minimum": 1
          },
          "number_of_guests": {
            "type": "integer",
            "minimum": 1
          },
          "status_type": {
            "type": "string"
          },
          "total_paid_amount_accurate": {
            "type": "string"
          }
        },
        "required": [
          "code",
          "start_date",
          "end_date",
          "expected_payout_amount",
          "guest_details",
          "guest_email",
          "guest_first_name",
          "guest_last_name",
          "guest_phone_numbers",
          "listing_security_price_accurate",
          "host_currency",
          "nights",
          "number_of_guests",
          "status_type",
          "total_paid_amount_accurate"
        ]
      }
    },
    "required": [
      "reservation"
    ]
  }

end
