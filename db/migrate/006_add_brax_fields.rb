# Use rake db:migrate_plugins to migrate installed plugins
class AddBraxFields < ActiveRecord::Migration
  def self.up
    add_column :customers, :software_id, :integer
    add_column :customers, :contact_name, :string
    add_column :customers, :contact_phone, :string
    add_column :customers, :printer_id, :integer
    add_column :customers, :software_version, :string
    add_column :customers, :blocked, :boolean
  end

  def self.down
    remove_column :customers, :software_id
    remove_column :customers, :contact_name
    remove_column :customers, :contact_phone
    remove_column :customers, :printer_id
    remove_column :customers, :software_version
    remove_column :customers, :blocked
  end
end
