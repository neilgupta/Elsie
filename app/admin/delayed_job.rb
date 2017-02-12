ActiveAdmin.register Delayed::Job do
  actions :all, except: [:new, :create, :edit, :update, :destroy]
  config.sort_order = 'run_at_asc'
end
