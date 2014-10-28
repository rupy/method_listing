# -*- coding: utf-8 -*-
require "nokogiri"
require "open-uri"
require "optparse"
require "set"

#opts = OptionParser.new
params = ARGV.getopts("c:")

# option
set = Set.new [1,2,3]
types = ["関数名", "マクロ名", "構造体"]
if params["c"].nil?
  c = 2 # default: code\u4e0a\u4f4d6\u6841
elsif !set.include?(params["c"].to_i) 
  puts "Error"
else
  c = params["c"].to_i
  # p c
  p types[0..c-1]
  
  url = "http://www.c-tipsref.com/reference.html"
  doc = Nokogiri::HTML(open(url))
  
  # title array
  header =  doc.css("h3").map{|h3| h3.text.gsub(/ \(.+?\)/,"")}
  
  sum = 0
  doc.css('div.list').each_with_index do |divlist,i|    
    puts "# #{header[i]}"
    
    case header[i]
      when "complex.h" then column = 3
      when "math.h" then column = 3
      else column = 1
    end
    divlist.css('table.reference-list').each do |table|
      tb_type = 0
      th_text = ""
      table.css('tr').each_with_index do |tr,j|
        tr.css('th').each_with_index do |th,k|
          if j + k == 0
            th_text = th.text.gsub(/\t/,"") 
            #p th_text, j, k
          end
          case th.text.gsub(/\t/,"")
            when "関数名" then tb_type = 1
            when "マクロ名" then tb_type = 2
            when "構造体名" then tb_type = 3
          end
        end # tr

        if tb_type <= c
          puts th_text if j == 0
          if tr.css('td').length != 0 
            func = tr.css('td').map{|td| td.text.gsub(/\t/,"")}
            if tb_type == 1
              puts func[0..column-1] 
            else
              puts func[0] 
            end
          end
        end
        #    tr.css('td').each_with_index do |td, idx|
        #      p td.text.gsub(/\t/,"")
        #    end
      end
    end 
    print "\n"
  end
end
