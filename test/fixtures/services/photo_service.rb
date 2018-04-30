class PhotoService
	def initialize(file_path, current_user, files)
		@photo_data = CsvParser.new(file_path).parse
		@current_user_key = current_user.user_key
		@files = hyraxify(files)
	end

	def hyraxify(files)
		if files
			files.map do |file|
				Hyrax::UploadedFile.create(
															 file: file.original_filename,
															 user_id: @current_user_key,
															 file_set_uri: file.tempfile
				)
			end
		end
	end

	def create_photos
		counter = 0
		@photo_data.each do |photo_data|
			photo = Photo.new
			photo.title = [photo_data[:title]]
			photo.depositor = @current_user_key
			photo.item_identifier = photo_data[:identifier]
			photo.date_of_original = [photo_data[:date_of_original]]
			photo.decade = [photo_data[:decade]]
			photo.subject = [photo_data[:subject]]
			photo.file_name = photo_data[:file_name]
			photo.location_depicted = photo_data[:location_depicted]
			photo.note = photo_data[:note]
			photo.series = photo_data[:series]
			photo.collection = photo_data[:collection]
			photo.curatorial_area = photo_data[:curatorial_area]
			photo.creator = [photo_data[:creator]]
			if photo.save!
				if @files
				photo_files = [] << @files.pop.temp_file.to_s
				# Take a look at the actor
				# create_files_actor.rb < invoked from
				# patch into or modify the actor stack
				#  AttachFilesToWorkJob.perform_later(env.curation_concern, files, env.attributes.to_h.symbolize_keys)
				#   env.curation_concern - work
				#  files - array or something of hyrax::uplaodedfile
				#  https://github.com/curationexperts/laevigata/blob/master/app/lib/importer/migration_import_job.rb
				AttachFilesToWorkJob.perform_later(photo, photo_files)
				end
				counter += 1
			end
		end
		counter
	end
end

