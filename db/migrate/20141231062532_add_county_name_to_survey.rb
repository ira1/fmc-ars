class AddCountyNameToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :countyname, :string
  end
end
