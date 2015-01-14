
module MyCustomHelper
	def delta_percent_to_s(a,b)
    # inum & dnum must be positive
    if 0==(a+b) then
        str=''
    else
	    str='Δ'+(100*(a - b)/(a+b)).to_i.abs.to_s+'%'
    end
    return str
  end
end