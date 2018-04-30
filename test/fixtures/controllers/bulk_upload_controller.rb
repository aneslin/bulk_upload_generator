class BulkUploadController< ApplicationController
	helper Openseadragon::OpenseadragonHelper
	# Adds a few additional behaviors into the application controller
	include Blacklight::Controller
	include Hydra::Controller::ControllerBehavior

	# Adds Hyrax behaviors into the application controller
	include Hyrax::Controller
	include Hyrax::ThemedLayoutController
	with_themed_layout '1_column'


	protect_from_forgery with: :exception

	def index
	end

	def csv_upload
		@models = ['Photo']
	end

	def upload_csv
		files = params['files']
		uploaded_file = params['file'].path
		work_type = params['Work type']
		count = 0
		if work_type == "Photo"
			photo_service = PhotoService.new(uploaded_file, current_user, files)
			count = photo_service.create_photos
		end
		redirect_back(fallback_location: :root)
		flash[:notice] = "#{count} #{work_type}(s) successfully queued for upload!"
	end
end


