#-------------------------------------------------------------------------------------
# Decode Location Aware Names to Latitude & Longitude ver 1.0
# Usage: ruby decode.rb RERI-NUCA
# http://locationawarenames.org
# Rober Dam roberdam@twitter.com / robert@ubicate.me
#-------------------------------------------------------------------------------------
class Minseg
  def now(texto) 
    if $latlongms.index texto then 
      retorno = ($latlongms.index texto)
      return retorno.to_s.rjust(3,'0')
      #return retorno
    else
      abort ("Incorrect segment")
    end
  end
end
  
class Segu
  def now (texto) 
    if $one.index texto then 
      retorno = ($one.index texto)
      return retorno
    else
      abort ("Incorrect Segment")
    end
  end
end



class Latlo
  def now (texto,tipo) 
    if tipo==1 then
          if $latp.index texto then
            retorno =($latp.index texto)
            if retorno>90 then
              abort ("Incorrect latitude >90")
            end
            return retorno
          else
            if $latn.index texto then
              retorno =($latn.index texto)
              if retorno>90 then
                abort ("Incorrect latitude >90")
              end
              if retorno == 0 then
                  return ("-0")
               end
              return (retorno *-1)
            else 
              abort ("Latitud incorrecta 4")
            end
          end
    else 
          if $latp.index texto then
            retorno =($latp.index texto)
            if retorno>180 then
              abort ("Incorrect Longitude >180")
            end
            return retorno
          else
            if $latn.index texto then
              retorno =($latn.index texto)
              if retorno>180 then
                abort ("Incorrect Longitude")                            
              end
              if retorno == 0 then
                  return ("-0")
              end
              return (retorno *-1)
            else
                   abort ("Incorrect Longitude")
            end
          end
        
    end
  end
      
end


class Decode
  def now(texto,which) 
    
      analize=Latlo.new
      minuseg=Minseg.new      
      segundin=Segu.new      
    case texto.strip.length      
      when 4
        if (texto[0].upcase.delete ("DGJKLMNRST")).length ==0  then
          lat=analize.now(texto[1..3],which)          
          segu=segundin.now(texto[0])
          return (lat.to_s+"."+segu.to_s)
        else
          abort ("Segment #{which} incorrect")   
        end    
      when 5 
          abort ("Segment #{which} incorrect")   
       when 6
          lat=analize.now(texto[3..5].strip,which)
          minu=minuseg.now(texto[0..2].strip)
          return (lat.to_s+"."+minu.to_s)
       when 7     
          if (texto[6].upcase.delete ("DGJKLMNRST")).length ==0  then   
            se= segundin.now(texto[6])
            lat=analize.now(texto[3..5].strip,which)
            minu=minuseg.now(texto[0..2].strip)
             minu=minu.to_s+se.to_s    
            return (lat.to_s+"."+minu.to_s)
           else
              abort ("Segment #{which} incorrect")   
           end
        when 8
              abort ("Segment #{which} incorrect")   
        when 9
            lat=analize.now(texto[3..5].strip,which)
            minu=minuseg.now(texto[0..2].strip)
            minu2= minuseg.now(texto[6..8].strip)
            return (lat.to_s+"."+minu.to_s+minu2.to_s)
        end

  end
end


if ARGV[0].nil? then
  abort("ERROR: No arguments, try using format XXXX-XXXX Example: RERI-NUCA ")
end

unless ARGV[0].include? "-" then
  abort("ERROR: Wrong format, try using format XXXX-XXXX Example: RERI-NUCA ")
end

parts = ARGV[0].split ("-")  
if parts[1].nil? then
  abort ("ERROR: try format XXXXXX - XXXXXX")
end
  
if parts[0].strip.length < 3 then
     abort ("ERROR: Wrong format on first part")
end

if parts[1].strip.length < 3 then
  abort ("ERROR: Wrong format on second part")
end
        
  
  
latlong=[]
$latlongms=[]
$latp=[]
$latn=[]
latfinal=""
lonfinal=""

consonantsplit ="BCDFGJKLMNPRSTZ".split ("")
consonants ="BCDFGJKLMNPRSTZ"
#We exclude "HQVWXY" from consonants & consonantsplit

vocals = "AEIOU"
abc = "ABCDEFGIJKLMNOPRSTUVXZ".split ("")
#We exclude "HQWY" from abc
$one="DGJKLMNRST".split ("")
  
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
          $latp << latlong[i] 
          $latn << latlong[i+1] 
    end
  
#Create arrays of minutes & seconds.  
    consonantsplit.each do |x|
      for i in 0..consonants.size-1
        for z in 0..vocals.size-1
          result= x+vocals[z]+consonants[i]
          $latlongms << result

        end
      end
    end  
 
  
#--------------------------------  
  firstpart=parts[0].strip    
  secondpart=parts[1].strip
  send = Decode.new
  la = send.now(firstpart,1)  
  lo = send.now(secondpart,2)  
  puts "Latitude #{la}, Longitude #{lo}"
  
  

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
  