module Dhcp
  class Lease
    def self.fetch_all
      raise NotImplementedError, 'Rails.configuration.x.dhcp_lease_provider does not implement self.fetch_all'
    end
  end
end
