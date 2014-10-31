class AddRolesToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :role_composer, :boolean
    add_column :surveys, :role_recording, :boolean
    add_column :surveys, :role_salaried, :boolean
    add_column :surveys, :role_performer, :boolean
    add_column :surveys, :role_session, :boolean
  end
end
