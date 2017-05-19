class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.integer :accomidation
      t.integer :travelling
      t.integer :food
      t.integer :othercharges

      t.timestamps
    end
  end
end
