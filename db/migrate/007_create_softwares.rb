# Use rake db:migrate_plugins to migrate installed plugins
class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :softwares
  end
end
