first_user = User.where(email: Settings.user.first_user)
if first_user.blank?
  puts 'Creating %s...' % Settings.user.first_user
  begin
    user = User.create!(email: Settings.user.first_user, role: 'admin', is_active: true, password: Settings.user.first_default_pw, password_confirmation: Settings.user.first_default_pw)
  rescue => e
    puts e.message
  end
  Profile.create! user: user, name: 'Admin'
end

unless File.exist?("#{Dir.home}/#{Settings.path.project_root}/#{Settings.path.custom}/engine.config")
  unless File.directory?("#{Dir.home}/#{Settings.path.project_root}/#{Settings.path.custom}")
    FileUtils.mkdir_p("#{Dir.home}/#{Settings.path.project_root}/#{Settings.path.custom}")
  end
  FileUtils.cp_r("#{Rails.root}/planet/engine.config", "#{Dir.home}/#{Settings.path.project_root}/#{Settings.path.custom}/engine.config")
end

puts "CompleteSeed"
