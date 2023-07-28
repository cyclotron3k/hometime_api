class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :guest, null: false, foreign_key: true
      t.string :code, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :nights, null: false
      t.integer :guests, null: false
      t.integer :children, null: false
      t.integer :adults, null: false
      t.integer :infants, null: false
      t.string :status, null: false
      t.decimal :security_price, precision: 10, scale: 2, null: false
      t.decimal :payout_price, precision: 10, scale: 2, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.string :currency, limit: 3, null: false

      t.timestamps
    end
    add_index :reservations, :code, unique: true
  end
end
