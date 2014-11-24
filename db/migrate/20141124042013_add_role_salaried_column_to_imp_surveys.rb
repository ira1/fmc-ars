class AddRoleSalariedColumnToImpSurveys < ActiveRecord::Migration
  def change
    add_column :imp_surveys, :role_salaried, :boolean
  end
end
