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
        if device.hostname =~ /phone|android/i
          # assume if 'phone' or 'android' are in the hostname,
          # this is going to be used as an occupancy sensor.
          device.occupancy = true
          device.friendly_name = device.hostname.gsub(/i?phone|android|[\-_]/i, '').sub(/s$/, '')
        else
          device.friendly_name = device.hostname.gsub(/[\-_]/, ' ').gsub(/\d/, '').strip
        end

        # TODO notify somebody of a new device
      end
      if device.occupancy? && !device.new_record?
        device.reachable?
      else
        device.save!
      end
      device
    end
  end
end
