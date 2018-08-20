require 'pry'
require 'nokogiri'
require 'open-uri' 
require 'launchy'

class CatBreeds::Scraper
     attr_accessor :breeds, :webs, :reference, :charac, :name, :web
     URL = "http://www.vetstreet.com"   #Ask Technical coach if BP?

     def initialize
        @breeds = [] 
        @webs = []
            
     end  

     def get_page
         html =  Nokogiri::HTML(open("http://www.vetstreet.com/cats/breeds"))
            
        # #GET BREEDS NAMES           
        # #mental note:nokogiri returns all cats names in one position, not array.
         
        # html.css(".hub-breed-list.columns.three").text.split("\n            ").each { |b|
         
        #        if b != "" && b.length > 1               
        #         #    self.breeds << b
        #         breed =  CatBreeds::Breed.new(b)             
        #        end    
        #      binding.pry  
        # }   

        # #GET BREEDS PARTIAL WEBPAGE
        # #mental note:nokogiri returns all cats names in one position, not array. 
        # html.css(".hub-breed-list.columns.three li").each {|w| 
        #     # @webs << URL+w.css("a").attribute('href').value
        #     breed.web << URL+w.css("a").attribute('href').value
        #  }       
         
       html.css("div.desktop-experience #hub-breed-list-container").children[3].css("a").each { |b|               
                breed =  CatBreeds::Breed.new(b.text)             
                breed.web = URL+b.attribute("href").value 

       }
         

    end  
    # def get_profile(website,breed)
    def get_profile
       
        charac = { }
        
        CatBreeds::Breed.all.each { |b| 
                    html =  Nokogiri::HTML(open(b.web))
                    
                    #GET THE REFERENCE TABLE FOR PRINTING IN CLI- PROCESS ONLY ONE TIME
                    if CatBreeds::Breed::reference.length == 0
                    html.css(".desktop-experience table tr td").each { |w|  
                            
                                        v = []
                                        #mental note: the html has an error in one class name, this code correct the error to get the data.
                                        if w.attribute("class").value == "title" || w.attribute("class").value == "title first"  || w.attribute("class").value == "title "
                                            v = w.text.delete("\n\t").split("                                                                     ")
                                            v[1] = v[1].strip                                 
                                            CatBreeds::Breed::reference <<  v            
                                        end        
                                }
                     end       
                        
                    #GET CHARACTERISTIC OF KITTIES AND VALUES TO BUILD INSTANCE ATTRIBUTES. ASSUMPTIONS: ALL THE CHARACTERISTICS HAVE RATING.
                     html.css(".desktop-experience table tr td.rating").each_with_index { |w , index|
                                
                            charac[CatBreeds::Breed::reference[index][0].downcase.tr(" ","_")] = w.text.gsub!(/[a-zA-Z]/,'').strip.to_i  #transform the value in integer
                      }
                        
                     b.add(charac)                   
       }      
       

     end    
    #   def make_breeds
    #        self.get_page
    #        self.breeds.each_with_index { |b,index|
    #        breed =  CatBreeds::Breed.new(b,@webs[index])    
    #        self.get_profile(@webs[index], breed)        
    #        }           
    #   end  
      def make_breeds           
           self.get_page 
           self.get_profile      
                   
      end   
      

end    