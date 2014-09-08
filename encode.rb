#-------------------------------------------------------------------------------------
# Encode Latitude & Longitude to Location Aware Names ver 1.0
# Usage: ruby encode.rb 65.7 -170.6
# http://locationawarenames.org
# Rober Dam roberdam@twitter.com / robert@ubicate.me
#-------------------------------------------------------------------------------------

# At least 2 arguments.
if ARGV[0].nil? then
  abort("ERROR: No arguments, try using latitude & longitude Example:. -25.2968 -57.5666 ")
end
if ARGV[1].nil? then
  abort("ERROR: Wrong arguments, you need both latitude & longitude Example:. -25.2968 -57.5666 ")
end

#------------  Create arrays and variables.
latlong=[]
latlongms=[]
latp=[]
latn=[]
latfinal=""
lonfinal=""

consonantsplit ="BCDFGJKLMNPRSTZ".split ("")
consonants ="BCDFGJKLMNPRSTZ"
#We exclude "HQVWXY" from consonants & consonantsplit

vocals = "AEIOU"
abc = "ABCDEFGIJKLMNOPRSTUVXZ".split ("")
#We exclude "HQWY" from abc
one="DGJKLMNRST".split ("")


# Create latitude & longitude arrays.
    for i in 0..4
        for z in 0..4
            abc.each do |x|  
            result= vocals[i]+x+vocals[z]
            unless result.delete("AEIOU")=="" 
              # We discard the all vocals combinations, Ex: AAA, AEA, etc.
                  latlong << result
            end
          end
        end   
     end

# Store positive & negative values
   (0...362).step(2) do |i|
          latp << latlong[i] 
          latn << latlong[i+1] 
    end
  
#Create arrays of minutes & seconds.  
    consonantsplit.each do |x|
      for i in 0..consonants.size-1
        for z in 0..vocals.size-1
          result= x+vocals[z]+consonants[i]
          latlongms << result

        end
      end
    end  
 
  
#--------------------------------
latitude = ARGV[0].split(".")
longitude= ARGV[1].split(".")

  if (latitude[0].delete '-').to_i >90 then
    abort("ERROR: Wrong Latitude ")
  end  
  if (longitude[0].delete '-').to_i >180 then
    abort("ERROR: Wrong Longitude ")
  end  
    
  if latitude[0][0]=="-" then
    lati1 = latn[(latitude[0].delete! '-').to_i]
  else
    lati1 = latp[(latitude[0]).to_i]
  end

 case latitude[1].length  
    when 1
     latfinal =one[latitude[1][0].to_i]+lati1
    when 2
     latfinal = latlongms[((latitude[1][0..1]).to_i*10)]+lati1
    when 3
     latfinal =latlongms[((latitude[1][0..2]).to_i)]+lati1
    when 4
     latfinal =latlongms[(latitude[1][0..2]).to_i]+lati1+one[(latitude[1][3]).to_i]
    when 5
     latfinal = latlongms[((latitude[1][0..2]).to_i)]+lati1+latlongms[((latitude[1][3..4]).to_i*10)]
    when 6
     latfinal =latlongms[((latitude[1][0..2]).to_i)]+lati1+latlongms[((latitude[1][3..5]).to_i)]
  end

  if longitude[0][0]=="-" then
    longi1 = latn[(longitude[0].delete! '-').to_i]
  else
    longi1 = latp[(longitude[0]).to_i]
  end    

  case longitude[1].length  
    when 1
      lonfinal=one[longitude[1][0].to_i]+longi1
    when 2
      lonfinal= latlongms[((longitude[1][0..1]).to_i*10)]+longi1
    when 3
      lonfinal= latlongms[((longitude[1][0..2]).to_i)]+longi1
    when 4
      lonfinal=latlongms[(longitude[1][0..2]).to_i]+longi1+one[(longitude[1][3]).to_i]
    when 5
      lonfinal=latlongms[((longitude[1][0..2]).to_i)]+longi1+latlongms[((longitude[1][3..4]).to_i*10)]
    when 6
      lonfinal=latlongms[((longitude[1][0..2]).to_i)]+longi1+latlongms[((longitude[1][3..5]).to_i)]
  end    

    puts "#{latfinal}-#{lonfinal} "
    
#---------------------------------------------------------------------------------------------------------
# The MIT License (MIT)
# Copyright (c) 2014 Robert Dam

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#---------------------------------------------------------------------------------------------------------