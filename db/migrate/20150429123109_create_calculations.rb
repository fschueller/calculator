class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.string :equation
      t.float :result

      t.timestamps null: false
    end
  end
end
