class AddCountyInfoToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :countyfips, :string
    add_column :surveys, :state, :string
  end
end
