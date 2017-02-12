ActiveAdmin.register Device do
  menu priority: 1
  actions :all, except: [:new, :create, :destroy]

  permit_params :occupancy, :friendly_name

  scope :all
  scope :mobile, default: true
  scope :online

  config.filters = false

  index do
    column 'MAC Address', :mac
    column :friendly_name
    column :occupancy
    column :connected
    column :hostname
    column 'IP Address', :ip
    column :expires_at
    column :last_seen_at
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs 'Details' do
      input :occupancy
      input :friendly_name
    end
    actions
  end
end
