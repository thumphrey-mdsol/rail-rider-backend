class CreateTrainlines < ActiveRecord::Migration[6.0]
  def change
    create_table :trainlines do |t|
      t.string :color
      t.string :name
      t.string :img_url
      t.string :destination
      t.string :status
      t.string :status_description

      t.timestamps
    end
  end
end
