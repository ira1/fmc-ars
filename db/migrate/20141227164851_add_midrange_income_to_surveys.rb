class AddMidrangeIncomeToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :midrange_income, :integer
  end
end
