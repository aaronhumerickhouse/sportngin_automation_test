# sportngin_automation_test

#Setup
Mac/Linux -> Follow the Steps below

Windows -> Bypass all setup and start at the Instructions section

Ruby and Windows don't play well together.  It's not worth the time to get it setup.
This being said, if it takes too long to setup on Mac/Linux, move on to Instructions.
This way we will have at least something as an example to speak to.

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

## Instructions
I've created two spec files sample_spec.rb and task_spec.rb.  Your job is to complete task_spec.rb based on the example from sample_spec.rb.  The library is setup to do so.  For simplicity, do not worry about using dates at all.

### Credentials
You will be given an email account with credentials.  Please put them in `resources/config.yml`.  We are doing this to have a page setup for you in the application.

###Application Under Test
http://www.kalmban.com

###Documentation
Code documentations is found in `doc/index.html`

###Submitting
Make sure we can have access to your work during the interview.  The preferred method is to keep it on Github under your own account.  We will be able to log in and put it on one of the monitors.  Otherwise, please bring it on a flash drive.

### Note
The project uses Watir-Webdriver and a custom created page-object library. Watir-Webdriver is a wrapper around Selenium that's easier to read and use.
