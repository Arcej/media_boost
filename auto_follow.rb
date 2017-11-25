require 'watir'
require 'headless'
require 'pry' #ruby REPL
require 'rb-readline' #ruby IRB
require 'awesome_print'
require_relative 'credentials'

username = $username_GE
password = $password_GE
user = "black_moon_salon"
follow_counter = 0
MAX_FOLLOWS = 39

#%w[--headless --disable-gpu --no-sandbox] para no mostrar el navegador
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

              #Navigate to users page
    browser.goto "instagram.com/#{user}/"
             #Navigate tu followers page
    browser.a(:class=>"_t98z6").exists?
    ap "Followers from #{user}"
    browser.a(:class=>"_t98z6").click
    sleep(3)

loop do
  while follow_counter < 701 do
      10.times do |follow|
        browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
        sleep(2)

                   #click follow
        if browser.button(:class=>"_qv64e _gexxb _4tgw8 _njrw0").exists?
          browser.button(:class=>"_qv64e _gexxb _4tgw8 _njrw0").click
          follow_counter += 1

          ap "Follows made #{follow_counter}"
        else
          ap "No media to follow"
        end
      end
      ap "===============#{Time.now}==============="
      #break if follow_counter == 39
      ap "People Followed #{follow_counter}"
      sleep(120)
  end
end


Pry.start(binding)
