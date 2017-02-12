class DeviceSerializer < ActiveModel::Serializer
  attributes :mac, :occupancy, :connected, :friendly_name, :hostname, :ip, :last_seen_at, :created_at
end
