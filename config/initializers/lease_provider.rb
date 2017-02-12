# Update this file as necessary to create a class that parses your DHCP leases
# and responds to `fetch`, which returns an array of hashes in the format
# {
#   hostname: 'my-iphone',
#   ip: '192.168.1.1',
#   mac: 'ee:ff:4b:de:7e:1b',
#   expires: 2017-02-12 10:50:47 -0600
# }

require 'nokogiri'

module Asus
  class Lease
    LEASE_URL = 'http://cellspot.router/Main_DHCPStatus_Content.asp'
    USERNAME = ENV['router_username']
    PASSWORD = ENV['router_password']

    def self.fetch
      html = `curl -s #{LEASE_URL} --user #{USERNAME}:#{PASSWORD}`
      now = Time.now
      text = Nokogiri::HTML(html).xpath('//table//textarea[1]').text

      text.split("\n").compact.drop(1).map { |r| r.split(' ').compact }.map do |row|
        # convert expires duration (ie "23:40:04") into number of seconds
        expire_duration = row[3].split(':')
        expires_in_seconds = (0..2).sum {|i| expire_duration[i].to_i * 60**(2-i) }

        {
          hostname: row[0],
          ip: row[1],
          mac: row[2],
          expires: now + expires_in_seconds
        }
      end
    end
  end
end

Rails.configuration.x.dhcp_lease_provider = Asus::Lease
