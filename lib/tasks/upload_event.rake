require "csv"
namespace :upload_event do
	desc "Upload the event data from csv"
	task :dump => :environment do
		filename = "#{Rails.root}/public/events.csv"
		CSV.foreach(filename, headers: true) do |row|
		  Event.find_or_create_by(title: row["title"], start_time: row["starttime"], end_time: row["endtime"], description: row["description"], all_day: row["allday"])
		end
	end
end
