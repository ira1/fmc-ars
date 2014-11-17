class AddExperienceGroupConsolidatedToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :experience_group_consolidated, :integer
  end
end
