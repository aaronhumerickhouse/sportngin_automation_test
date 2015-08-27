# sportngin_automation_test

##Install Git
https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

##Github
Create github account (if doesn't already exist)

##Fork project
Fork the project: https://github.com/aaronhumerickhouse/sportngin_automation_test


##Project Setup
###Ensure Ruby is installed
If ruby is installed, `ruby -v` should produce something like `ruby 1.9.3p551 (2014-11-13 revision 48407) [x86_64-darwin13.4.0]`

If on Windows: http://rubyinstaller.org/
If on Mac or Linux: https://www.ruby-lang.org/en/documentation/installation/

###Bundler
gem install bundler

###Gems
bundle install

###Run Tests
rspec

##Caution
Don't spend too much time getting the setup to work.  If you can't, try to write the test best you can.  We will be able to talk about decisions that way.

## Instructions
I've created two spec files sample_spec.rb and task_spec.rb.  Your job is to complete task_spec.rb based on the example from sample_spec.rb.  The library is setup to do so.  For simplicity, do not worry about using dates at all.

### Credentials
You will be given an email account with credentials.  Please put them in `resources/config.yml`.  We are doing this to have a page setup for you in the application.

###Application Under Test
http://www.kalmban.com

###Documentation
Code documentations is found in `doc/index.html`

### Note
The project uses Watir-Webdriver and a custom created page-object library. Watir-Webdriver is a wrapper around Selenium that's easier to read and use.
