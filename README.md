
# Warning
If you hate writing HTML, this project is not for you. Try [Slim](https://github.com/stonean/slim) or one of the many other template languages. Each has its strengths, weaknesses and place in this world.

## About
Simple Attribute Language (sal.rb) is logic-less with valid HTML. 

## Why
With all the other options, why sal.rb?

Having spent many years in `<% %>` land with JSP and ERB templates and seeing the issues that arise with this approach, I wanted to eliminate the ability to freely code in views. My first attempt implementing this idea was [RuHL](https://github.com/stonean/ruhl).

RuHL had issues though. First and least important from a proof a concept angle was the name. RuHL rules! Bleh. 

More to the point: RuHL wasn't compilable and therefore didn't fit easily into the world of Ruby templates. After a short time, the frameworks I had support for (Rails and Sinatra) progressed past RuHL's ability to hack its way into the framework.

Earlier this year I started work on [sal.js](https://github.com/stonean/sal.js) to tackle another view related issue. It just so happens that the idea behind RuHL was the way to make sal.js a reality. While working on sal.js, I refined the approach RuHL took to make it smarter.

As it happens, request were made to bring RuHL up-to-date and make it work with the latest and greatest. Also as it happens, this was turning out to be more work that I wanted to put into RuHL knowing the architecture simply wouldn't work in the long term. 

After weeks of distractions and no real clue how to make a compilable RuHL , the solution presented itself and here we are.

## Syntax
sal.rb works by parsing your HTML looking for a data-sal attribute and executing the value as a method call against the rendering scope. How sal acts depends on the type of response.

#### String
The simplest of return values is a string. This tells sal to make this value the contents of the tag.

Lets say there's a method called title:
    
    def title
      'This is different'
    end

Then you have some markup in your template like so:

    <h1 data-sal="title">This will be replaced</h1>

When you render the template you'll get:

    <h1>This is different</h1>

As you've no doubt noticed, the data-sal attribute is gone and the contents have been replaced with the value of the `title` method call.


#### Hash
The next return value sal knows about is a hash. With the exception of an :html key, sal simply treats each the keys as attributes to be added to the tag. The value of the html key becomes the value of the tag.

Lets say there's a method called login_link:
    
    def login_link
      if logged_in?
        { :href => '/logout', :html => 'Log out' }
      else
        { :href => '/login', :html => 'Log in' }
      end
    end

Then you have some markup in your template like so:

    <a data-sal="title">Login link</a>

If logged_in is false you'll get:

    <a href='/login'>Log in</a>


#### Array
If the return value is an array, sal repeats the markup for each item in the array applying the contents accordingly.


Lets say there's a method called days_of_week:

    def days_of_week
      %w{Monday Tuesday Wednesday Thursday Friday Saturday Sunday}
    end

Then you have some markup in your template like so:

    <select name="day">
      <option>Please choose</option>
      <option data-sal='days_of_week'>Monday</option>
    </select>

When you render the template you'll get:

    <select name="day">
      <option>Please choose</option>
      <option>Monday</option>
      <option>Tuesday</option>
      <option>Wednesday</option>
      <option>Thursday</option>
      <option>Friday</option>
      <option>Saturday</option>
      <option>Sunday</option>
    </select>

But wait, you want the value to be different...

    def days_of_week
      [ {:value => 0, :html => 'Monday'},
        {:value => 1, :html => 'Tuesday'},
        {:value => 2, :html => 'Wednesday'},
        {:value => 3, :html => 'Thursday'},
        {:value => 4, :html => 'Friday'},
        {:value => 5, :html => 'Saturday'},
        {:value => 6, :html => 'Sunday'} ]
    end

Same markup as above, but when you render you'll get:

    <select name="day">
      <option>Please choose</option>
      <option value='0'>Monday</option>
      <option value='1'>Tuesday</option>
      <option value='2'>Wednesday</option>
      <option value='3'>Thursday</option>
      <option value='4'>Friday</option>
      <option value='5'>Saturday</option>
      <option value='6'>Sunday</option>
    </select>

That's the basics for now...more documenation to come.


