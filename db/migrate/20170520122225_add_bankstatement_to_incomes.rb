class AddBankstatementToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :incomes, :bankstatement, :integer
  end
end
