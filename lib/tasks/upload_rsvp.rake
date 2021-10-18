namespace :upload_rsvp do
	desc "Upload the rsvp data from csv"
	task :dump => :environment do
		filename = "#{Rails.root}/public/events.csv"
		@arr = []
		@new_hash = {}
		CSV.foreach(filename, headers: true) do |row|
		  data_manipulation = row["users#rsvp"].try(:split, ";")#
		  data = data_manipulation.map { |e| e.try(:split, "#") } if data_manipulation
		  event_title = row["title"]
		  if data
			  data.each do |d|
			  	@new_hash = {username: d[0], status: d[1], title: event_title}
			  	@arr << @new_hash
			  end
			end
		end
		uniq_data =  @arr.uniq{|x| x.values_at(:username, :status, :title) }
		uniq_data.each do |data|
			user = User.find_by_username(data[:username])
			event = Event.find_by_title(data[:title])
			Rsvp.find_or_create_by(user_id: user.id, event_id: event.id, status: data[:status])
		end
	end
end
