require 'watir'
require 'pry' #ruby REPL
require 'rb-readline' #ruby IRB
require 'awesome_print'
require_relative 'credentials'

username = 'goldenstate_mx@outlook.com'
password = 'jjgoldenstate10'
like_counter = 0
num_of_rounds = 0
max_likes = 1000

#open browser, navigate to login page
browser = Watir::Browser.new :chrome, switches: ['--incognito']
browser.goto "instagram.com/accounts/login/"

 #navigate to username and password fields inject info
 ap "loggin in.."
 browser.text_field(:name =>"username" ).set "#{username}"
 browser.text_field(:name =>"password" ).set "#{password}"

#click login button
browser.button(:class => '_qv64e _gexxb _4tgw8 _njrw0').click
sleep(2)

while true

  3.times do |i|
    browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
    sleep(1)
  end

#_8scx2
  if browser.span(:class => "coreSpriteHeartOpen" ).exists?
    browser.spans(:class => "coreSpriteHeartOpen" ).each { |val|
      val.click
      like_counter += 1
    }
    ap "Photos liked: #{like_counter}"
  else
    ap "No media to like"
  end
    num_of_rounds += 1
    puts "=============== #{like_counter / num_of_rounds} likes per round (on average)============="

    break if like_counter >= max_likes
  sleep(30)

end

Pry.start(binding)
