rails new . \
  --api \
  --skip-keeps \
  --skip-action-mailbox \
  --skip-action-cable \
  --skip-active-job \
  --skip-action-mailer \
  --skip-javascript \
  --skip-hotwire \
  --skip-asset-pipeline \
  --skip-active-storage \
  --skip-acion-text \
  --database=postgresql

rails generate controller Api::V1::Reservations

rails generate model guest \
  email:string:uniq \
  first_name:string \
  last_name:string

rails generate model reservation \
  guest:references \
  code:string:uniq \
  start_date:date \
  end_date:date \
  nights:integer \
  guests:integer \
  children:integer \
  adults:integer \
  infants:integer \
  status:string \
  security_price:decimal\{10,2\} \
  payout_price:decimal\{10,2\} \
  total_price:decimal\{10,2\} \
  currency:string\{3\}

rails generate model phone_number \
  guest:references \
  number:string
