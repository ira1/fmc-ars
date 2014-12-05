class AddRoleOtherColumnToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :role_other, :boolean
  end
end
