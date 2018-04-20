module ApplicationHelper

	def cal_price_diff(asking_price, last_price)
		return '-' if last_price == '-'
		diff = asking_price.gsub("£","").gsub(",","").to_i - last_price.gsub("£","").gsub(",","").to_i
		diff < 0 ? ("-£"+diff.to_s.gsub('-','')) : ("£"+diff.to_s)
	end
end
