require 'pry' #ruby REPL
require 'rb-readline' #ruby IRB
require 'awesome_print'
require_relative 'credentials'

username = $username_puerto
password = $password_puerto

#follows = "People Followed"
user = "puertodesannico"
followers = "Followers"
follow_counter = 0
unfollow_counter = 0
MAX_FOLLOWS = 39
MAX_UNFOLLOWS = 35

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
ap "Succesfull Login #{username}"

              #Navigate to users page
    browser.goto "instagram.com/#{user}/"
             #Navigate tu followers page
    browser.a(:class=>"_t98z6").exists?
    ap "Followers #{user}"
    browser.a(:class=>"_t98z6").click
    sleep(3)

#loop do

#follows.each do |follow|

    200.times do |i|
      browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
      sleep(3)

      if browser.button(:class => '_qv64e _t78yp _4tgw8 _njrw0').exist?
      browser.button(:class => '_qv64e _t78yp _4tgw8 _njrw0').click
      unfollow_counter += 1
        ap "People Unfollowed #{unfollow_counter}"
      end
    end
