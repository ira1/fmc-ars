
module MyCustomHelper
	def delta_percent_to_s(a,b)
    # inum & dnum must be positive
    if 0==(a+b) then
        str=''
    else
	    str='Δ='+(100*(a - b)/(a+b)).to_i.abs.to_s+'%'
    end
    return str
  end
  
  def FilterProfileName 
    #return params["mgenre"]
    genre_text=["Other", "Classical", "Jazz", "Rock", "Country"]
    if params.has_key?("mgenre") and params["mgenre"]!='ALL' then
      return genre_text[params["mgenre"].to_i]+' musicians'
    else
      return "All Musicians"
    end
  end
  
  def makeHelpTip(str)
    data="<span class='tip' title='#{str}'>#{image_tag "help_icon.png", :size => "16x16"}</span>"
    data=data.html_safe
  end
  
end