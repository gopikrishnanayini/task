class CreateIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :incomes do |t|
      t.string :source
      t.integer :income

      t.timestamps
    end
  end
end
