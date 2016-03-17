require 'nokogiri' # gem install nokogiri
require 'open-uri' # already part of your ruby install


class HomesController < ApplicationController
  def search
  	if session['picture_ids']
  		session.delete('picture_ids')	
  	end
  
  end

  def imgur_search



  end
  
  def imgur_query
    url = params[:query]
    #open webpage
    picture = Picture.new()
   check = picture.url_check(url)
    if check ==false
      flash[:message] ="The URL is invalid"
      redirect_to "/imgur_search"
    else
      doc = Nokogiri::HTML(open(url))
      img = doc.css("img").map{ |i| i['src'] }
      #go through each img and remove the ones that don't fit the http or https format. 
      images = []
      img.each do |i|
        if i[0]=="/" && i[1]=="/" 
          i.slice!(0)
          i.slice!(0)
            if i[0] =='i'
              i = "http://"+i
              images.push(i)  
            end  
        end
      end
      picture_ids = []

      #Go through each index of an array
      images.each do |i|
        pic = Picture.new
        pic.image_remote_url(i)
        pic.save
        #put ids in an array
        picture_ids.push(pic.id)
      end

      #   # # #put picture_id arrays into an array and session variable. 
        session['picture_ids']= picture_ids
        redirect_to "/results"
    end
  end

  def query
  	url = params[:query]
  	#open webpage
    picture = Picture.new()
   check = picture.url_check(url)
    if check ==false
      flash[:message] ="The URL is invalid"
      redirect_to "/homes"
    else
      doc = Nokogiri::HTML(open(url))
      img = doc.css("img").map{ |i| i['src'] }
      #go through each img and remove the ones that don't fit the http or https format. 
      images = []
      img.each do |i|
        if i[0]=="h"
          images.push(i)  
        end
      end
     
      picture_ids = []

      #Go through each index of an array
      images.each do |i|
        pic = Picture.new
        pic.image_remote_url(i)
        pic.save
        #put ids in an array
        picture_ids.push(pic.id)
      end

      #   # # #put picture_id arrays into an array and session variable. 
        session['picture_ids']= picture_ids
        redirect_to "/results"
    end

  	#set file location

  	#set file name
  end
end
