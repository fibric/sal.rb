
# Warning
If you hate writing HTML, this project is not for you. Try [Slim](https://github.com/stonean/slim) or one of the many other template languages. Each has its strengths, weaknesses and place in this world.

## About
Simple Attribute Language (sal.rb) is logic-less with valid HTML

## Why
With all the other options, why sal.rb?

Having spent many years in `<% %>` land with JSP and ERB templates and seeing the issues that arise with this approach, I wanted to eliminate the ability to freely code in views. My first attempt implementing this idea was [RuHL](https://github.com/stonean/ruhl).

RuHL had issues though. First and least important from a proof a concept angle was the name. RuHL rules! Bleh. 

More to the point: RuHL wasn't compilable and therefore didn't fit easily into the world of Ruby templates. After a short time, the frameworks I had support for (Rails and Sinatra) progressed past RuHL's ability to hack its way into the framework.

Earlier this year I started work on [sal.js](https://github.com/stonean/sal.js) to tackle another view related issue. It just so happens that the idea behind RuHL was the way to make sal.js a reality. While working on sal.js, I refined the approach RuHL took to make it smarter.

As it happens, request were made to bring RuHL up-to-date and make it work with the latest and greatest. Also as it happens, this was turning out to be more work that I wanted to put into RuHL knowing the architecture simply wouldn't work in the long term. 

After weeks of distractions and no real clue how to make a compilable RuHL , the solution presented itself and here we are.

## Syntax

...Coming soon.

Refer to [sal.js](https://github.com/stonean/sal.js) for now.

