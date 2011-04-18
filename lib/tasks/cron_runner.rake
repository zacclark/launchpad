namespace :runners do
  namespace :all do
    
    desc "Update all widgets"
    task :update => :environment do
      User.all.each do |user|
        user.widgets.each do |wid|
          wid.update_data
        end
      end
    end
    
  end
end
