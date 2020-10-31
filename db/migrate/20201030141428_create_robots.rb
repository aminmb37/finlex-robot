class CreateRobots < ActiveRecord::Migration[6.0]
  def change
    create_table :robots do |t|
      t.string :name
      t.integer :x
      t.integer :y
      t.string :direction

      t.timestamps
    end
  end
end
