class CreateCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :commands do |t|
      t.string :cmdtype
      t.integer :step
      t.integer :xbfr
      t.integer :ybfr
      t.integer :xaftr
      t.integer :yaftr
      t.references :robot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
