class AddMoreDetailToJob2 < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :wolf_name, :string
    add_column :jobs, :lion_name, :string
    add_column :jobs, :dragon_name, :string

    add_column :jobs, :is_wolf, :boolean, default: true
    add_column :jobs, :is_lion, :boolean, default: true
    add_column :jobs, :is_dragon, :boolean, default: true
  end
end
