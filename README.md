# Elsie

https://github.com/neilgupta/Elsie

> A rising star in the Programming Division tasked with monitoring my network's hosts.

Elsie is a helper service for tracking all the devices on my network and pinging the mobile phones to notify my home automation system when somebody is home. It's essentially a more advanced version of [homebridge-people](https://github.com/PeteLawrence/homebridge-people).

The goal was to be able to use mobile phones on the network as an occupancy sensor, without having to maintain a hard-coded list of phones. I want my home automations to keep working if friends or family are present without me, so I need my software to be able to learn about new phones on its own.

Specifically, Elsie performs the following tasks:

* Scrape my router's DHCP lease logs to determine all devices on the network and their IP addresses
* Maintain a database of known devices so it can detect when a brand new device joins the network
* Constantly poll for connectivity status on devices marked for use as occupancy sensors

TODO:

* Alert Bernard (WIP, my home automation AI) when an occupancy device's connection status changes (i.e., somebody entered or left the home)
* Alert me when a new device joins the network so I can identify it and mark it as an occupancy sensor if appropriate
* Maybe add specs one day...

## Setup

Make sure you have ruby 2.3+ and Postgres installed.

1. `git clone git@github.com:neilgupta/Elsie.git`
2. `cd Elsie`
3. Unless you have an ASUS router, you'll need to edit `config/initializers/lease_provider.rb` to scrape wherever your DHCP leases are stored.
4. `bundle install`
5. `bundle exec rails db:create`
6. `bundle exec rails db:migrate`
7. `bin/start`
8. Go to http://localhost:5000/devices

If everything went well, you should either get a JSON response with a list of phones on your network right now or an empty array. If the latter, go to http://localhost:5000/admin and select which device(s) to use for occupancy and try again.

Note: obviously since we're scraping logs off the router and pinging devices, this service needs to be running within your local network. I'm using a Raspberry Pi, but any computer that can run ruby + postgres and has LAN access should work.
