
module MyCustomHelper
	def delta_percent_to_s(a,b)
    # inum & dnum must be positive
      if nil==(a && b) || 0==(a+b) then
          str=''
      else
  	    str='Δ='+(100*(a - b)/(a+b)).to_i.abs.to_s+'%'
      end
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
    data="<abbr class='tip' title='#{str}'><span class='fa fa-question-circle'></span></abbr>"
    data=data.html_safe
  end
  
end