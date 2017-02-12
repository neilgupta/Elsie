# Ping all devices with active leases and being used for occupancy every 10 minutes
Delayed::Periodic.cron 'Mobile Ping Poll', '*/10 * * * *' do
  Device.active_lease.mobile.each(&:reachable?)
end

# Ping all devices with active leases once per hour
Delayed::Periodic.cron 'Global Ping Poll', '25 * * * *' do
  Device.active_lease.each(&:reachable?)
end
