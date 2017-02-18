class Device < ApplicationRecord
  PING_THRESHOLD = 15

  scope :active_lease, -> { where("expires_at > ?", Time.now) }
  scope :mobile, -> { where(occupancy: true) }
  scope :online, -> { where(connected: true) }

  after_save :schedule_lease_renewal, if: :expires_at_changed?
  after_save :notify_bernard, if: :connected_changed?
  after_save :reachable?, if: :new_occupancy_device?

  def reachable?
    ping = Ping.pingecho ip
    update_attribute(:connected, ping)
    ping
  end

  def connected=(ping)
    # touch last seen at if we successfully pinged device
    write_attribute(:last_seen_at, Time.now) if ping

    if ping || last_seen_at.to_i < PING_THRESHOLD.minutes.ago.to_i
      # if we got a positive result, save it
      # if we got a negative result, we should wait for PING_THRESHOLD minutes
      write_attribute(:connected, ping)
    end

    connected
  end

  def expires_at_changed?
    # allow for 60 second difference in expires_at
    (expires_at.to_i - expires_at_was.to_i).abs > 60
  end

  private

  def new_occupancy_device?
    occupancy? && occupancy_changed? && last_seen_at.to_i < PING_THRESHOLD.minutes.ago.to_i
  end

  def schedule_lease_renewal
    Lease.send_later_enqueue_args(:renew, run_at: expires_at) if expires_at
  end

  def notify_bernard
    Bernard.notify self, :connection_changed
  end
end
