class HomesController < ApplicationController
	def index
	
	end

    def parsehtmlfile
        @htmlpage = Nokogiri::HTML(open("#{Rails.root}/public/testpage.html"))
        @ponum = @htmlpage.css("body").text.scan(/\bPO Number\b\s*:\s*\[(\d+)\]/).flatten
        @tracknum = @htmlpage.css("body").text.scan(/\bTrack It\b\s+\:\s+([^\n\r][A-Za-z]\d+)/).flatten.insert(2,nil).insert(5,nil)
        @output = @ponum.zip(@tracknum)
        respond_to do |format|
        	format.js
    	end
    end

    def viewhtmlfile
        send_file("#{Rails.root}/public/testpage.html",filename: "Parsefile.html",:disposition => "inline")       
        # respond_to do |format|
        #     format.html
        # end
    end

end
