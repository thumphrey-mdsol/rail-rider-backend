class CreateArrivals < ActiveRecord::Migration[6.0]
  def change
    create_table :arrivals do |t|
      t.integer :stop_id
      t.integer :trainline_id

      t.timestamps
    end
  end
end
