class AddTotalIncomeToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :incomes, :total_income, :integer
  end
end
