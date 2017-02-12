class DevicesController < ApplicationController
  def index
    Lease.renew
    render json: Device.mobile.online
  end
end
