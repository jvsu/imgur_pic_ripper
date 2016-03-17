class Picture < ActiveRecord::Base
	attr_reader :image_remote_url
	has_attached_file :image
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	def image_remote_url(url_value)
	    self.image = URI.parse(url_value)
	    # Assuming url_value is http://example.com/photos/face.png
	    # avatar_file_name == "face.png"
	    # avatar_content_type == "image/png"
	    @image_remote_url = url_value
  end

  	def url_check(url)
  	begin
      page = Nokogiri::HTML(open(url))
 	  
    rescue
    	return false
    
  end
  		
  	end
end
