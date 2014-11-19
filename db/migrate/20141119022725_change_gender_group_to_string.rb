class ChangeGenderGroupToString < ActiveRecord::Migration
  def up
    change_column :imp_surveys, :gender_group, :string
    change_column :surveys, :gender_group, :string
  end
  def down
   # change_column :imp_surveys, :gender_group, :integer
   # change_column :surveys, :gender_group, :integer
  end
end
