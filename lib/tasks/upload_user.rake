require "csv"
namespace :upload_user do
	desc "Upload the user data from csv"
	task :dump => :environment do
		filename = "#{Rails.root}/public/users.csv"
		CSV.foreach(filename, headers: true) do |row|
		  User.find_or_create_by(username: row["username"], email: row["email"], phone: "phone")
		end
	end
end
