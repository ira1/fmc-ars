class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :respondentid
      t.float :age
      t.boolean :FullTime

      t.timestamps
    end
  end
end
