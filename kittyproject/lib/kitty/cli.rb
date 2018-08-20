class CatBreeds::CLI

     

     def call  
        header       
        puts "Kitten list is coming:"
        call_websites
        menu
        
        
        
     end  
     def header
          puts <<-DOC
    ***************************************************************************************
    ***************************************************************************************
    *                                                                                     *
    *                       .............                .""".             .""".          *
    *               ..."""""             """""...       $   . ".         ." .   $         *
    *           ..""        .   .   .   .   .    ..    $   $$$. ". ... ." .$$$   $        *
    *         ."    . " . " . " . " . " . " . " .  "" ."  $$$"""  "   "  """$$$  ".       *
    *       ."      . " . " . " . " . " . " . " .     $  "                    "   $       *
    *      ."   . " . " . "           "   " . " . "  ."      ...          ...     ".      *
    *     ."    . " . "    .."""""""""...     " . "  $     .$"              "$.    $      *
    *    ."     . " . " .""     .   .    ""..   . " $ ".      .""$     .""$      ." $     *
    *   ."    " . " .       . " . " . " .    $    " $ "      "  $$    "  $$       " $     *
    *   $     " . " . " . " . " . " . " . "   $     $             $$.$$             $     *
    *   $     " . " . " . " . " . " . " . " .  $  " $  " .        $$$$$        . "  $     *
    *   $     " . " . " . " . " . " . " . " .  $    $      "  ..   "$"   ..  "      $     *
    *   ".    " . " . " . " . " . " . " . "   ."  "  $  . . . $  . .". .  $ . . .  $      *
    *    $    " . " . " . " . " . " . " . "  ."   "            ".."   ".."                *
    *     $     . " . " . " . " . " . "   .."   . " . "..    "             "    .."       *
    *     ".      " . " . " . " . " .  .""    " . " .    """$...         ...$"""          *
    *      ". "..     " . " . " . " .  "........  "    .....  ."""....."""                *
    *        ". ."$".....                       $..."$"$"."   $".$"... `":....            *
    *          "".."    $"$"$"$"""$........$"$"$"  ."."."  ...""      ."".    `"".        *
    *              """.$.$." ."  ."."."    ."."." $.$.$"""".......  ". ". $ ". ". $       *
    *                     """.$.$.$.$.....$.$.""""               ""..$..$."..$..$."       *
    *                                                                                     *
    ***************************************************************************************
    *************************************** WELCOME ***************************************
    ***************************************************************************************    
         DOC
     end 

     def call_websites
         scraper = CatBreeds::Scraper.new    
         scraper.make_breeds  #must be execute one time each time user execurte the program, reads 51 webpages.
         return scraper
     end
     
     def menu 
         puts "Select a number option"
         puts "1. Check kitties Breeds"
         puts "2. Search a breed by name."
         puts "3. List of most adaptable breeds"
         puts "4. List of most healthy breeds"
         puts "5. Say goodbye kittens.(Exit)"
         input = gets.strip.to_i
          
         until input.between?(1,5)   
                puts("")   
                puts "Bad Kitty!. Choose a correct option."
                menu            
         end

         case input
         when 1

             i = 0      
             CatBreeds::Breed.all.each { |b|
                i += 1
                puts "#{i}. #{b.name}"             
             }
             puts("Choose the number of breed you want to learn:")
             puts("")
             second_level_list(gets.chomp.to_i) 

          when 2   

            puts ("")
            puts ("Enter the first letter of the name") 
            str = gets.chomp           
            CatBreeds::Breed.search_breed_by_name(str) 
            puts ("")
            puts ("Choose the number of breed you want to learn:")
            second_level_list(gets.chomp)
            
          when 3

            CatBreeds::Breed.most_adap
            puts ("Type b for go back to the menu")
            str = gets.chomp
            until str == "b"  
                puts("")   
                puts "Bad Kitty!. Choose a correct option." 
                puts ("Type \"b\" for go back to the menu")
                str = gets.chomp         
            end
            menu

          when 4

            CatBreeds::Breed.most_healthy
            puts ("Type b for go back to the menu")
            str = gets.chomp
            until str == "b"  
                puts("")   
                puts "Bad Kitty!. Choose a correct option." 
                puts ("Type \"b\" for go back to the menu")
                str = gets.chomp        
            end
            menu

          else

            exit            
          end
     end    
     def second_level_list(input)  
              
            i = input.to_i-1
            puts "Breed name: #{CatBreeds::Breed.all[i].name}"
            puts "Characteristics:"
            CatBreeds::Breed::reference.each { |r0,r1|  
                      puts "--------------------------------------------------------------------------------------------------"         
                      puts "#{r0}:"
                      puts "#{r1}"
                      puts "Rating: #{CatBreeds::Breed.all[i].send(r0.downcase.tr(" ","_"))}"    
                      puts "--------------------------------------------------------------------------------------------------" 
                       
            }
           puts ("Type \"b\" for go back to the menu.")
           str = gets.chomp 
              

           until str == "b"  || str == "m"
                puts("")   
                puts "Bad Kitty!. Choose a correct option." 
                puts ("Type b for go back to the main menu")
                str = gets.chomp        
            end
            
           menu  
     end     


end