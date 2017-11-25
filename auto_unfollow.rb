require 'watir'
require 'headless'
require 'pry' #ruby REPL
require 'rb-readline' #ruby IRB
require 'awesome_print'
require_relative 'credentials'

username = $username_GE
password = $password_GE
user = "goldenestate_mx"
unfollow_counter = 0
MAX_UNFOLLOWS = 39

#open browser, navigate to login page
browser = Watir::Browser.new :chrome#, switches: %w[--headless --disable-gpu --no-sandbox]
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
ap "Succesfull Login #{username}"

              #navigate to users page
    browser.goto "instagram.com/#{user}/"
             #navigate tu followers page
    browser.a(:href=>"/#{user}/following/").exists?
    ap "Followers from #{user}"
    browser.a(:href=>"/#{user}/following/").click
    sleep(3)

loop do

  while unfollow_counter < 601 do

    5.times do |unfollow|
      browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
      sleep(3)

      if browser.button(:class=>"_qv64e _t78yp _4tgw8 _njrw0").exist?
        browser.button(:class=>"_qv64e _t78yp _4tgw8 _njrw0").click
        unfollow_counter += 1
        ap "Unfollows made #{unfollow_counter}"
      else
        ap "No media tu unfollow"
      end
    end
    ap "People Unfollowed #{unfollow_counter}"
    ap "===============#{Time.now}==============="
    sleep(120)
  end

end

Pry.start(binding)
