require 'watir'
require 'pry' #ruby REPL
require 'rb-readline' #ruby IRB
require 'awesome_print'
require_relative 'credentials'

username = $username_GE
password = $password_GE
like_counter = 0
num_of_rounds = 0
max_likes = 1000

#open browser and navigate to login page
browser = Watir::Browser.new :chrome
screen_width = browser.execute_script("return screen.width;")
screen_height = browser.execute_script("return screen.height;")
browser.driver.manage.window.resize_to(screen_width,screen_height)
browser.driver.manage.window.move_to(0,0)
browser.goto "instagram.com/accounts/login/"

 #navigate to username and password fields inject info
 ap "loggin in.."
 browser.text_field(:name =>"username" ).set "#{username}"
 browser.text_field(:name =>"password" ).set "#{password}"

#click login button
browser.button(:class => '_qv64e _gexxb _4tgw8 _njrw0').click
sleep(2)
ap "Succesfull login"

loop do

  while like_counter <= 999 do

    50.times do |like|
      sleep(1)

    if browser.span(:class=>"_8scx2 coreSpriteHeartOpen").exist?
      browser.span(:class=>"_8scx2 coreSpriteHeartOpen").click
        like_counter += 1

      ap "Photos liked: #{like_counter}"
    else
      ap "No media to like"
    end
      num_of_rounds += 1
      puts "=============== #{like_counter / num_of_rounds} likes per round (on average)============="
    end
      break if like_counter >= max_likes
    sleep(1000)

  end
end

Pry.start(binding)
