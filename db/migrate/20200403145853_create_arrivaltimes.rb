class CreateArrivaltimes < ActiveRecord::Migration[6.0]
  def change
    create_table :arrivaltimes do |t|
      t.string :line
      t.string :delay
      t.integer :arrival
      t.integer :departure
      t.integer :arrival_id
      t.string :direction

      t.timestamps
    end
  end
end
