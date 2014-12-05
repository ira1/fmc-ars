class AddRoleOtherToImpSurveys < ActiveRecord::Migration
  def change
    add_column :imp_surveys, :role_other, :boolean
  end
end
