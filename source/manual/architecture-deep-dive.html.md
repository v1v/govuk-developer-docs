---
owner_slack: "#govuk-developers"
title: Architectural deep-dive of GOV.UK
section: Applications
type: learn
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2019-06-17
review_in: 3 months
---

GOV.UK architecture is split between two main approaches of page delivery; static vs dynamic.

- Static pages are rendered and cached once. The cached version is delivered forever, making this approach cheap and resilient to traffic.
- Dynamic pages are rendered on-demand. This approach is required if page contents are determined by user input and pre-rendering every possible combination of user input would be impossible (search pages, for example).

We'll explain the architecture of GOV.UK from the inside out. This document assumes a basic knowledge of the [content store and content/publishing APIs](https://docs.publishing.service.gov.uk/apis/content-store.html).

## Publishing platform

TBC - explain that publishing apps use the publishing API to write content to the content store. Can reference the content-store.html rather than repeat info here.

## Static pages

When a publishing app triggers a change in the content store, the publishing API sends a message to [RabbitMQ](https://www.rabbitmq.com/), which is a message broker. A job which is subscribed to that event retrieves the content item and triggers a build (or a rebuild) of that content according to its `rendering_app`.

The output is saved to a static HTML file and stored in S3. The [cache-clearing-service](https://github.com/alphagov/cache-clearing-service) is also subscribed to the RabbitMQ message, and clears the cache of the old static version.

Finally, if this is a new page, the [router-api](https://github.com/alphagov/router-api) (which is also subscribed to the RabbitMQ message) tells the [router](https://github.com/alphagov/router) about the new content. The router loads the new route into memory (it uses [redis](https://redis.io/)) and the page becomes visible to the outside world.

If there is a frontend change (such as a new footer link) then the process above is triggered en-masse for _all_ documents, so that all static pages get the changes.

> Questions, TBC:
> - IS the rendered output stored in S3? (That's my assumption, needs confirming)
> - DOES a frontend change trigger an en-masse update? (Confirmation needed)
> - Where is this RabbitMQ magic happening - AWS?
> - What are the relevant repos (for the actual rendering)?

## Dynamic pages

All dynamic pages are effectively a specialised form of search page. Dynamic pages use the [search-api](https://github.com/alphagov/search-api) to fetch the content items required to render the page. And _this_ is why some content information lives in the search-api; it needs to know how to respond to certain queries.

TODO: fill this out:

- routing
- combination with 'static', 'content tagger' and the data warehouse (content-data-api?)

# Caching

Applies to static & dynamic alike. More TBC

Sits behind Fastly, which absorbs 70% of the traffic.

# Mirroring

# Emails

# Assets

# Analytics
