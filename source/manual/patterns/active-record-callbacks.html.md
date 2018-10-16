---
owner_slack: "#govuk-2ndline"
title: "Pattern: Active Record callbacks"
section: Patterns
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2018-09-25
review_in: 12 months
---

Rails' [Active Record callbacks](https://guides.rubyonrails.org/active_record_callbacks.html) allow you to trigger logic before and after a record is created, updated, or destroyed.

## What does it look like?

This code sends a welcome email for each new user:

```rb
class User < ApplicationRecord
  after_create :send_welcome_email

  def send_welcome_email
    # logic
  end
end
```

## Where callbacks don't work well

- The logic is outside of the normal code path. When reading code, the reader will need to know that certain callbacks exist.
- Callbacks [allow conditionals](https://guides.rubyonrails.org/active_record_callbacks.html#conditional-callbacks), which may introduce code that is hard to test

## Advice on callbacks

Be very hesitant to use Active Record callbacks in your application.

It is often clearer and more flexible to create a separate class that wraps your logic. In the example above, a class that creates a new user and sends the email:

```rb
class NewUserCreator
  def create_user
    create_user_record
    send_welcome_email
  end
end
```
