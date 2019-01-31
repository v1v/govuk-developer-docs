---
title: How to learn GOV.UK
parent: "/manual.html"
layout: manual_layout
section: Learn GOV.UK
owner_slack: "#govuk-2ndline"
last_reviewed_on: 2019-01-03
review_in: 3 months
---

Welcome to GOV.UK! Let's start off by saying that GOV.UK publishing system is _very_ complex. It can be daunting task to get to know the platform. This page is meant as a guide to learning about GOV.UK.

## Concept 1: frontend apps and publishing apps

The most important concept that of the split between frontends applications, publishing applications, and APIs.

By "Frontend apps", we mean applications that render content to visitors to [www.gov.uk](https://www.gov.uk/) For example, a [page on corporation tax](https://www.gov.uk/corporation-tax) is rendered by an application called [government-frontend][government-frontend].

"Publishing apps" are used by editors to publish content to GOV.UK. For example, [specialist-publisher][specialist-publisher] publishes [specialist documents][specialist documents].

Our APIs sit between the frontend apps and publishing apps. For example, the [search api](/apps/search-api.html) is used by frontends to search for pages.

More detail:

- [Look at the applications page to see all the different applications](https://docs.publishing.service.gov.uk/apps.html)

[specialist documents]: https://www.gov.uk/cma-cases/legal-services-market-study
[government-frontend]: /apps/government-frontend.html
[specialist-publisher]: /apps/specialist-publisher.html

## 2. Core concept: the publishing platform

## 3. Core concept: the infrastructure

Applications are hosted on an infrastructure [configured using puppet][govuk-puppet].
They are deployed using [capistrano scripts][govuk-app-deployment].

[govuk-puppet]: https://github.com/alphagov/govuk-puppet
[govuk-app-deployment]: https://github.com/alphagov/govuk-app-deployment

## 3. What the applications are like

Most of our applications are built using [Ruby on Rails][rails].

[rails]: http://rubyonrails.org/


## 5. Deep dive: frontend apps

You can use the [chrome extension][extension] to find out which application
is rendering any given page.

You can [read more about the frontend architecture on GOV.UK](/manual/frontend-architecture.html).

[extension]: https://github.com/alphagov/govuk-browser-extension

## 6. Deep dive: publishing apps

The apps are secured by behind a [single signon system][signon]. They use an
[omniauth adapter called gds-sso][gds-sso] to authenticate the user.

[gds-sso]: https://github.com/alphagov/gds-sso
[signon]: /apps/signon.html
