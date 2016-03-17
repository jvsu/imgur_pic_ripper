require 'rubygems'
require 'zip'

class PicturesController < ApplicationController
  def results
  	picture_ids = session['picture_ids']
  	@pictures = Picture.find(picture_ids)
  end

  def download
  	pic_params = params
  	#remove auth token, controller, action
  	pic_params.delete("authenticity_token")
  	pic_params.delete("controller")
  	pic_params.delete("action")
  
  	input_file_names = {}
  	keys = []
  	pic_params.each do |key,value|
  		@pic = Picture.find(value)
  		input_file_names[key]= @pic
  		keys.push(@pic.id)
  	end

  	#create a temp file
  
 temp_file = Tempfile.new("download.zip")


  Zip::File.open(temp_file.path, Zip::File::CREATE) do |zipfile|
  input_file_names.each do |key, value|
    # Two arguments:
    # - The name of the file as it will appear in the archive
    # - The original file, including the path to find it
    
    zipfile.add(key,value.image.path(false))
  end
  zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
 end

 send_file temp_file.path, :type => 'application/zip',
       :disposition => 'attachment',
       :filename => "download.zip"
	temp_file.close






	# session.delete('picture_ids')	

    #clear session and images from the database

    #redirect to home page with flash message

  end
end
