class Airbnb < ParserBase

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
    guest = Guest.find_or_initialize_by email: payload["guest"]["email"]
    guest.assign_attributes(
      first_name: payload["guest"]["first_name"],
      last_name: payload["guest"]["last_name"],
    )
    guest.save!
    guest
  end

  def build_reservation(guest)
    reservation = Reservation.find_or_initialize_by code: payload["reservation_code"]
    reservation.assign_attributes(
      guest: guest,
      start_date: payload["start_date"],
      end_date: payload["end_date"],
      nights: payload["nights"],
      guests: payload["guests"],
      children: payload["children"],
      adults: payload["adults"],
      infants: payload["infants"],
      status: payload["status"],
      security_price: payload["security_price"],
      payout_price: payload["payout_price"],
      total_price: payload["total_price"],
      currency: payload["currency"],
    )
    reservation.save!
    reservation
  end

  def build_phone_numbers(guest)
    phone_number = PhoneNumber.find_or_initialize_by guest_id: guest.id, number: payload["guest"]["phone"]
    phone_number.save!
    phone_number
  end

  SCHEMA = {
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {
      "reservation_code": {
        "type": "string"
      },
      "start_date": {
        "type": "string"
      },
      "end_date": {
        "type": "string"
      },
      "nights": {
        "type": "integer"
      },
      "guests": {
        "type": "integer"
      },
      "adults": {
        "type": "integer"
      },
      "children": {
        "type": "integer"
      },
      "infants": {
        "type": "integer"
      },
      "status": {
        "type": "string"
      },
      "guest": {
        "type": "object",
        "properties": {
          "first_name": {
            "type": "string"
          },
          "last_name": {
            "type": "string"
          },
          "phone": {
            "type": "string"
          },
          "email": {
            "type": "string"
          }
        },
        "required": [
          "first_name",
          "last_name",
          "phone",
          "email"
        ]
      },
      "currency": {
        "type": "string"
      },
      "payout_price": {
        "type": "string"
      },
      "security_price": {
        "type": "string"
      },
      "total_price": {
        "type": "string"
      }
    },
    "required": [
      "reservation_code",
      "start_date",
      "end_date",
      "nights",
      "guests",
      "adults",
      "children",
      "infants",
      "status",
      "guest",
      "currency",
      "payout_price",
      "security_price",
      "total_price"
    ]
  }

end
