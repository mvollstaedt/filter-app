[![Build Status](https://travis-ci.org/zealot128/filter-app.svg)](https://travis-ci.org/zealot128/filter-app)

#  News aggregator app

This is a Ruby-on-Rails app for running (German) news aggregator websites. Today, it powers:

* http://www.hrfilter.de  (German news of HR/personal/recruiting)
* http://www.fahrrad-filter.de (German/English news of cycling topic)


## Reasoning

I want to follow news of those two areas but struggle with RSS, as it is too much for me too process - I want to see the most "relevant" sources at once, without investing too much time. Other sources, like Twitter + Reddit I found too noisy to follow.

This is why I created that app

## News fetching + scoring algorithm

The admin of the apps curates a list of trusted sources. Those will regularly checked for new content. Following news sources are supported:

* RSS/Atom feeds (FeedSource)
* Podcast via RSS/Atom (similar as FeedSource but different visual)
* Twitter Streams
* (in planning) RedditSources - subscribe whole /r/'s


In similar fashion, the app checks popularity of the news in social network, that means:

* Facebook likecount (as reported by Facebook Like Button)
* Twitter retweets + favorites (as reported by Twitter API)
* XING + LinkedIn shares (as reported by regarding Widgets)
* Reddit total score sum in all subreddits (if exists)
* Each of those sources is configured with a different value (e.g. Facebook likes are more common, so less value than XING share)

The admin of the sites can give a Source individual:

* Base factor (that means, how much "Likes" any link of that website is worth, can also be negative too remove noise from some sources)
* Multiplicator, e.g. 0.2, 1.0, 2.0  - each like will be multiplied by that number -- Some sources have a much higher reach and can be leveled out so the news are more broad


Altogether, the score is calculated regularly for fresh links.
For Display on the homepage, the freshness is also important - the older the link, the more the score is reduced.

## Topics

The topic matching is very simple - just simple keyword lists. That means, the categorization is far far from perfect or even good. It might be an area of further development :)

## Newsletter

It is possible to subscribe via E-Mail. Then, once per week on sunday, you will receive a Mail with from the selected topics.

# Development

## Setting up the Rails Environment

### Using a Virtual Machine or Linux (recommended)

In case you are using *Windows* or *OSX* as OS you should consider developing in a VM since
it is alot easier to set up the rails environment.
You just need *Vagrant* (which is THE tool to simply configure and manage headless VM's)
and Oracle's *VirtualBox* to be able to spawn VM's.

[Here](https://coderwall.com/p/vm2uha/setting-up-a-brand-new-postgres-powered-ruby-rails-development-environment-with-vagrant) you can find a link pointing to a pretty good installation guide using *postgreSQL* as database since this project requires postgreSQL as well (disclaiming that the guide might be 100% correct, just in case ;) ).

### Using Windows or OSX

Just don't. It is not recommended to do so since you are going to run in a lot of frustrating problems when setting up
the environment. Vagrant is the way to go though. Once you've set up the environment you can take the VM and easily
install it on any machine you want only requiring Vagrant and VirtualBox!

## Setting up project

As it is a fully functioning Rails app, you can try to run it yourself. First make sure to have Ruby at least 2.0 installed and bundler, then:

```
git clone ...
cd ...
bundle install
rake environment db:create
rake db:migrate
rails server
```

before the rake commands, you might have to create a config/application.yml (see config/application.hrfilter.yml as example) and adjust config/database.yml and config/secrets.yml too your needs.

If you'd like, you can try to import some of the HRfilter sources for an initial seed:

```
rake db:seed
```
