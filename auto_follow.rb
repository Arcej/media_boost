require 'watir'
require 'headless'
require 'pry' #ruby REPL
require 'rb-readline' #ruby IRB
require 'awesome_print'
require_relative 'credentials'
#thor

username = $username_GE
password = $password_GE

#follows = "People Followed"
user = "milenamontalvo_"
followers = "Followers"
follow_counter = 0
unfollow_counter = 0
MAX_FOLLOWS = 39
MAX_UNFOLLOWS = 35

#open browser, navigate to login page
browser = Watir::Browser.new :chrome, switches: %w[--headless --disable-gpu --no-sandbox]
browser.goto "instagram.com/accounts/login/"

 #navigate to username and password fields inject info
 ap "loggin in.."
 browser.text_field(:name =>"username" ).set "#{username}"
 browser.text_field(:name =>"password" ).set "#{password}"

#click login button
browser.button(:class => '_qv64e _gexxb _4tgw8 _njrw0').click
sleep(2)
ap "Succesfull Login #{username}"

              #Navigate to users page
    browser.goto "instagram.com/#{user}/"
             #Navigate tu followers page
    browser.a(:class=>"_t98z6").exists?
    ap "Followers from #{user}"
    browser.a(:class=>"_t98z6").click
    sleep(3)

#loop do

while follow_counter < 701 do

    35.times do |i|
      browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
      sleep(2)

                   #click follow
      if browser.button(:class=>"_qv64e _gexxb _4tgw8 _njrw0").exists?
        browser.button(:class=>"_qv64e _gexxb _4tgw8 _njrw0").click
        follow_counter += 1

        ap "Follows made #{follow_counter}"

      end
    end
    ap "===============#{Time.now}==============="
    #break if follow_counter == 39
    #break if unfollow_counter >= MAX_UNFOLLOWS
    ap "People Followed #{follow_counter}"
    sleep(1200)
end
#end


Pry.start(binding)
