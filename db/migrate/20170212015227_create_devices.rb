class CreateDevices < ActiveRecord::Migration[5.0]
  def self.up
    create_table :devices do |t|
      t.boolean :occupancy, null: false, default: false
      t.boolean :connected, null: false, default: false
      t.string :mac, null: false
      t.string :friendly_name
      t.string :hostname
      t.string :ip
      t.timestamp :expires_at
      t.timestamp :last_seen_at
      t.timestamps
    end

    add_index :devices, :mac, unique: true
  end

  def self.down
    drop_table :devices
  end
end
