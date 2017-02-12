class Lease
  def self.fetch
    Rails.configuration.x.dhcp_lease_provider&.fetch ||
      raise(NotImplementedError, 'Rails.configuration.x.dhcp_lease_provider not configured')
  end

  def self.renew
    fetch.map do |lease|
      device = Device.find_or_initialize_by(mac: lease[:mac])
      device.hostname = lease[:hostname]
      device.ip = lease[:ip]
      device.expires_at = lease[:expires]
      if device.new_record?
        # notify somebody of a new device
      end
      if device.occupancy?
        device.reachable?
      else
        device.save!
      end
      device
    end
  end
end
