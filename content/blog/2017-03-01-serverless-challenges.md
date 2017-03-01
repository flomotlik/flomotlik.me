+++
title = "Challenges of Serverless in 2017"
date = "2017-02-27"
draft = "false"
+++

Serverless and the hype around it have exploded last year. Now that we're comfortably in the new year I want to take some time to discuss the challenges we face to bring Serverless even more into the mainstream in 2017. This post will be an overview followed up by more in-depth posts about individual topics in the future.


The definition of Serverless has been a moving target. Since the launch of Lambda and the start of Serverless as a term we've seen a lot of different ways it has been described. AWS changed their messaging around Serverless at last ReInvent going from Serverless is the same as FaaS to Serverless encompasing many different and necessary services they provide (like databases, queues, ...). Lambda and FaaS for them is an enabler of Serverless, but not Serverless itself anymore. Check out [Tim Wagners talk on the State of Serverless](https://www.youtube.com/watch?v=AcGv3qUrRC4) for a deeper insight into how AWS thinks about Serverless going forward.

The main principles when building a Serverless infrastructure are still the same though:

1. Less Control
2. Less Responsibility
3. Increased Automation
4. Gradual Escalation of Control and Responsibility when necessary

All those principles lead to you being able to focus more on product than infrastructure. To be able to use these four principles and build on top of existing AWS Services in a completely Serverless way we have to overcome a few challenges in the near future.

## Challenges

### 1. Problem, not Service focused documentation and content

AWS is pretty diligent in documenting all the features that exist, but the major downside of the way they document is that its hard to determine which service should be used in which way to solve a specific problem. For example "What is the best way to rapidly ingest and analyse lots of small data packets". While the answer to this question might be clear to many users (in most cases Kinesis), the guidance on getting to this answer is strewn across many different places. This leads to a hard learning curve for new, but also long-time users. AWS itself, but also the community, should provide better guidance what "the right way" to solve a specific problem is. With Serverless infrastructure leaning on top of existing services there should be a best way for most problems and only a few left that need a little more customisation.

What's especially important is documentation and examples that are deployable for users to test and evaluate. A good example should include a way to exercise the parts of a system so the user can see how it responds and get a better feeling and understanding of the deployed service. Just providing examples without adequate docs and tooling to exercise the examples will not lead to good enough understanding and trust.

### 2. Better low level tooling without additional abstractions

In the past it was pretty natural for developers to use tools with all kinds of abstractions on top of AWS, because the services AWS provided were very low-level. E.g. If you're using EC2 instances directly you want an abstraction on top of that to group parts of your application together and make it easier to deal with. With every subsequent move of AWS building their own abstraction (e.g. ElasticBeanstalk, ECS and Lambda) on top of their basic infrastructure having even more abstractions in your tooling made less and less sense.

Today we're in a place where we're still building tools as if we need those abstractions, when in reality AWS provides good enough abstractions but has bad tooling on top of it. For example CloudFormation is a great service (though it definitely has its rough edges) but the tooling to work with it is atrocious. Building templates in a modular way is a pain and the AWS tooling (mainly the awscli) provides no easy way to follow deployments with any sense of usability. I've recently built [a small tool](https://github.com/flomotlik/formica) to make this nicer to use and there are [many](https://github.com/remind101/stacker) [many](https://github.com/cloudreach/sceptre) others working on this problem as well.

The awscli itself is a prime example of this problem as well. It exposes the base actions you can do against the API, but using it for continuous delivery presents a lot of usability problems. I recently built a [small wrapper](https://github.com/flomotlik/awsie) on top of the awscli to make looking up physicalids from logical CloudFormation ids a little simpler. In my opinion we will need more of these kinds of tools and accompanying documentation and examples that bring better usability to basic aws tooling, but without adding any additional abstractions on top of what is already there.

### 3. Make it easier to include new features and services into your infrastructure

AWS is relentlessly shipping new services. For Serverless infrastructure to grow it is important that these services and features can be used and introduced into existing infrastructure as quickly as possible. We want to be on a constant path of reducing control and responsibility where possible for more focus on our product. Today, mostly due to lack of documentation and tooling, this is pretty hard to achieve.

While missing automation (e.g. no CloudFormation support) are definitely an issue stopping us from moving faster, these can be overcome with better tooling and documentation. Especially when that tooling and documentation takes into account that new services will be launched and integrated constantly.

### 4. Testing, Monitoring and Operations

With Lambda and FaaS becoming a larger part of our compute infrastructure testing methods have already started to change. While unit testing individual functions is relatively easy, testing the combination of all functions and infrastructure pieces as one becomes harder and harder.

While we will still be able to test some parts of our system in isolation before roll-out, testing the whole system before every time will most likely slow down the rollout process too much. This means we need to start putting a lot more emphasis on post-release validation, monitoring and self-healing of infrastructure. Charity Majors has a great [two part Series on Serverless operations](https://charity.wtf/2016/05/31/operational-best-practices-serverless/) and Mike Roberts talked about this as well in his [on the future of Serverless post](https://www.infoq.com/articles/future-serverless).

AWS provides us all the services we need to make good validation, monitoring and self-healing a reality. Too often they are hidden behind bad tooling and usability though. The recently announced X-Ray looks very promising and better tooling and documentation can definitely help CloudWatch to become a great service. But without us as a community, and of course AWS, providing clearer guidance, examples and tooling on how to effective manage Serverless infrastructure with as little manual interaction as possible we won't be able to sufficiently move to Serverless anytime soon.

### 5. Ignore Multi Provider Compatibility

There has been quite a bit of talk around cross provider compatibility for tooling and documentation over the last months. Even AWS dabbled with standardisation when they provided SAM as a standard (even though that seems more as a marketing stunt). In my opinion we should not try to build our tooling for cross-provider usage as it forces the tools to provide an abstraction layer and hide the few things we can control on each provider. It also forces tools to become the smallest common denominator in terms of usability between providers.

The strength of Serverless infrastructure is to put everything that is not your core product code into services and have those services work together through some glue where you only worry about your code and no infrastructure. The scope of services each provider has are very different, so trying to build an infrastructure that can be moved as one to another provider is not really feasible any more. It was when the cloud was mostly server instances, but that time is in the past.

Now of course that doesn't mean that you shouldn't worry about lock-in, just that you have to think about it differently. Its unlikely you're going to move from one provider to another completely, as there is too much surface area that is covered by the specific services one provider has. And costs aren't the necessary differentiator anymore as they were in the past, because factoring in additional necessary man-power and speed of innovation make simple cost comparisons meaningless. We have to build infrastructure in a way where its possible to include best of breed services from another provider, but at the same time still get the most out of the existing services we already use without having to fall back to DIY. 

## Conclusions

The ideas behind Serverless aren't new. Its a continuation of practices and paradigms that have been growing over at least the last 10 years, if not more. We're now at a point though where we don't just have the underlying services that cover most use cases we have in our infrastructure, but also the no-infrastructure glue in between those services.

To really make the most out of this we have to start breaking with a few old habits, especially around tooling and documentation. The one tool fits all infrastructure and deployment category is going to hurt us more than it will help in the future. Instead we should, through a mix of education, documentation and better low level tooling, provide a better onboarding and deployment experience. This will make evolving our infrastructure with every new service that comes out a lot simpler.

I will go into more detail on several of the afforementioned topics in future blogposts, so follow me on [twitter](https://twitter.com/flomotlik) or get the feed from this blog to see those follow ups as well.

Thanks to the following people for review and feedback
* [Paul Johnston](https://twitter.com/pauldjohnston)
* [Maciej Winnicki]
* [Mike Roberts]
* [Ryan Scott Brown]
* [John McKim]
* [John Chapin]

## Also Check out

* [Overview article on serverless architecture by Mike Roberts](https://martinfowler.com/articles/serverless.html)
* [Charity Majors 2 part Series on Serverless operations](https://charity.wtf/2016/05/31/operational-best-practices-serverless/)
* [Tim Wagner on the State of Serverless](https://www.youtube.com/watch?v=AcGv3qUrRC4)
* [Mike Roberts on the future of Serverless](https://www.infoq.com/articles/future-serverless)