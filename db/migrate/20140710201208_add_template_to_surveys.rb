class AddTemplateToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :template, :boolean
  end
end
