class AddPrimaryGenreGroupToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :primary_genre_group, :integer
  end
end
