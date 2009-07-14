# Use rake db:migrate_plugins to migrate installed plugins
class AddNotesField < ActiveRecord::Migration
  def self.up
    add_column :customers, :notes, :text
  end

  def self.down
    remove_column :customers, :notes
  end
end
