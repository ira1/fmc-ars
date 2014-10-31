class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :respondentid
      t.integer :batch
      t.boolean :full_time
      t.float :age

      t.timestamps
    end
  end
end
