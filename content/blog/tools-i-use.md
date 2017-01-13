+++
date = "2014-11-29T13:38:17+01:00"
title = "Tools and Services I use"

+++

This Blogpost contains a number of services and tools I’ve used in the past either at Codeship or on my own and which I enjoy greatly. They have a short description and mention other tools they work well with. I will update the list over time.

This should serve as an easy to use index for services you want to use with your team or on your own.

Last Updated 11th December 2014


## Hosting


### Heroku

Very simple Hosting for various languages and frameworks. Together with their Postgres hosting a very compelling offering that we still use at Codeship after being a customer for years. The only disadvantage is that you’re very tied to their infrastructure and AWS us-east, so when they are down, you are down (which happens very rarely).


### AWS Elastic Beanstalk

Platform as a Service offering by AWS. Easiest way to get started on AWS but still be able to use the full power of AWS and all of it’s services in the future. It uses all the common AWS services under the hood, so migrating off Elastic Beanstalk onto a fully self managed AWS infrastructure is relatively easy. Supports Docker Containers so you have full control over the system running your application


### S3 -> Static pages

S3 is a great way to host static pages. We’ve been hosting our docs there for a long time. You can read more about hosting there in their Documentation. You can even use custom SSL certificates by either going through
Cloudfront or Cloudflare


## Development


### Github

Simply the best way to manage your code and work in your team. Nothing comes close.


### Invision

Great way to share designs with the team and comment on those designs. We’re using it regularly at Codeship.


### Ngrok

Great service for making something you run on your local machine available to anyone. Can be really helpful, although I haven’t used it often.


### Codeship

We obviously deploy anything we have through Codeship and it is very helpful to have one tool set up for deployment of all of our applications.


## Database


### Heroku Postgres

I’m really impressed and delighted by all the tooling that Heroku has built around their Postgres offering. From followers to all the insights into the database they implemented it definitely makes a lot of sense to use it in case you’re on Heroku.


## Logging, Monitoring, Metrics & Alerting


### Papertrail

We recently switched to Papertrail as our log storage service and it’s great. The whole interface is very minimalistic, so you can fully focus on getting the data and insight you need. It works really really well, was quickly set up and all of our engineering team loves it. A++


### Librato Metrics

We’ve used Librato for a while and I’m very impressed. Their Heroku integration is great and automatically takes data written to logs by Heroku to create graphs. You can even do custom metrics in your logs to create graphs (http://support.metrics.librato.com/knowledgebase/articles/265391-heroku-native-and-custom-metrics-without-the-libra). Together with their great UI it’s an awesome tool to use for your metrics. And it’s very easy to get started.


### NewRelic

At this point NewRelic really has become the default choice for collecting metrics about your running application. We’ve been using it on our Rails app for years and while we thankfully don’t have to use it often, whenever we do look into it it has all the important information we need to increase performance of our application.


### Pagerduty

When people pay you for a service you want to make sure you’re up all the time and your team is properly notified if not. Pagerduty makes it very simple to set up on-call schedules and trigger alerts from different tools like Librato or NewRelic so your team gets notified and possibly woken up when something dramatic happens. We’ve waited way too long to introduce it and I don’t want to build anything that has customers without it anymore.


### Statuspage.io

Having a status page is very important to communicate with your customers when something goes wrong, but managing your own status page is a hassle. Statuspage.io solves this very nicely. You can manage incidents manually, but they also have integrations with many different providers so when Github has issues for example our status page shows that automatically. Very helpful. Make sure to have your status page at a separate domain and different DNS service so it’s reachable even when your site is not.


### Rollbar

They do a great job of tracking and visualising exceptions that happen in the system. You can hide exceptions if they are not important and add tags after a new deployment happened which is very helpful. Great tool for a very important task.


### Google Docs

Many of our most important business metrics are calculated by a daily task that then writes the results to Google Docs. We’ve been using this setup for years and it serves us very well. It’s very adaptable, easy to understand and build. I’ve written a small ruby gem to do the Google Docs upload and you can read more about the setup on our blog: http://blog.codeship.com/backend-metrics-done-right/ . For data that can be generated from your database Google Docs works great, give it a try.


## Domains & DNS


### DNSimple

DNSimple is our DNS provider of choice for their simple yet powerful interface and especially their great API. We want our DNS to be deployed from a Githhub repository, the same way everything else is deployed at Codeship. Thus a good API was a prerequisite for choosing DNSimple. DNSimple recently (December 2014) suffered a DDOS attack which took down their service completely for hours so you might want to look into a backup solution as well.


### Cloudflare

During the DNSimple outage in December 2014 we’ve migrated some of our DNS to Cloudflare which was very easy to do. We’re looking into using both DNSimple and Cloudflare for our DNS in the future so if one dies we still have a fallback. I haven’t used their other services so far.


### Hover

Hover has been my Domain purchase service of choice for a long time. They have a very easy interface, don’t try to upsell and just work. They automatically renew, but let you know many times in advance. In a market that is littered with bad actors Hover is one of the nice guys that I trust a lot.


### DigiCert

When we needed to renew our certificate (November 2014) I looked around a bit and decided on purchasing from Digicert. It was incredibly easy, their support was super helpful and fast. Will absolutely buy from them again in the future and you should too.


## Team Management


### Slack

We’re using Slack all day for any kind of communication in the team. With two offices and remote people a good chat system is critical, and Slack is an excellent system. We’re pushing lots of different messages from Github, Papertrail and other services into Slack and it works really well.


### Google Hangout

Whenever we do a call in our team we use Google Hangout. Anybody can join from their laptops or phones if necessary. It works well enough that we’ve never really looked into something else. Hangoutnow.io is a website that will open and redirect you to a new google hangout. Really helpful when you just want to open up a new one quickly.


### Appear.in

Appear is a WebRTC based system, so your browser supports video calling without you having to do anything. For 1/1 calls it’s great.


### Google Apps

We manage all of our accounts through Google Apps. It’s just the simplest way to get email and google docs for all of your team, while being able to manage it.


### Trello

We use Trello for our Kanban Board. It works well enough.


### Pivotal Tracker

We’re currently experimenting with Pivotal Tracker for parts of our work and might roll it out to the whole team in the future. It’s a great project management service


## User Communication


### Sendgrid

We use Sendgrid for sending hundreds of thousands of build status emails a month. It works great, is easy to set up and doesn’t die.


### Mailchimp

We use Mailchimp for managing and sending our newsletters. Very easy to set up and manage.


### Intercom

We use Intercom extensively to track the success of our users, contact them if they need help and send out updates in our application. Their ability to add arbitrary metadata to any user and group them according to the metadata is very powerful. It allows to send automated emails on various events so we make sure nobody gets lost on the Codeship. You can read more about it in one of our blogposts


## Blogging


### WPEngine

We’ve moved our Blog to WPEngine a while ago. They provide great Wordpress hosting that is definitely worth the price. If you need more control over your blog go there.


### Svbtle

For my personal blog I’m using Svbtle, as it works well and is simple.


## Productivity Tools


### 1Password

Managing passwords is a hassle. You should have a unique password per service but want those to be stored safely. 1password is simply the best service to manage your passwords. I use the browser extensions and their Mac app constantly. Well worth the price and better than anything else I’ve used before.


### Wunderlist

Wunderlist is the first todo list service that works for me. I collect work and personal todos there, it syncs between my various devices, has great usability and just gets out of my way and lets me do my work. You should definitely give it a try if you struggle to be organised.


### Gmail (The Andi Klinger way)

Most people struggle with keeping overview on their email account. I’ve recently set up my Gmail as described in the blogpost by Andi, a friend of mine. Managing my emails has gotten a lot simpler and definitely much less stressful. If you struggle with email and use Gmail give this a try.


### Mac Notes

I use the Notes application on my Mac all the time (including for this Blogpost) to collect my thoughts. They are synced to Google so they are always available to me. Very handy and easy to use tool to collect your thoughts


### IdoneThis

We started using IdoneThis at Codeship a few weeks ago and it’s awesome. We completely dropped our engineering standup. It let’s everyone see what everybody else is working on without having to sit through a meeting. Especially for a remote team you should give it a try.
