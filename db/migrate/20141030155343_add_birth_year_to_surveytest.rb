class AddBirthYearToSurveytest < ActiveRecord::Migration
  def change
    add_column :surveytests, :birth_year, :integer
  end
end
