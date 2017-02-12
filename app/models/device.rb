class Device < ApplicationRecord
  def connected?
    Ping.pingecho ip
  end
end
