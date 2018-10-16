---
owner_slack: "#govuk-2ndline"
title: "Pattern: Feature tests in RSpec"
section: Patterns
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2018-09-25
review_in: 12 months
---

Acceptance testing means writing high-level acceptance tests for your application.

We recommend a style of feature tests that was [described by FutureLearn in this blog post](https://about.futurelearn.com/blog/how-we-write-readable-feature-tests-with-rspec).

## What does it look like?

```rb
RSpec.feature "Showing a document summary" do
  scenario "User views a document" do
    given_there_is_a_document
    when_i_visit_the_document_page
    then_i_see_the_document_summary
  end

  def given_there_is_a_document
    @document = create(:document, title: "Title", summary: "Summary", created_at: 1.month.ago)
  end

  def when_i_visit_the_document_page
    visit document_path(@document)
  end

  def then_i_see_the_document_summary
    expect(page).to have_content(@document.title)
    expect(page).to have_content(@document.summary)

    within("div.app-c-metadata") do
      expect(page).to have_content(@document.created_at.strftime("%l:%M%P on %d %B %Y"))
      expect(page).to have_content(@document.updated_at.strftime("%l:%M%P on %d %B %Y"))
    end
  end
end
```

## When this works well

Your code should be readable in 2 ways: just the scenario, and by reading the methods from top to bottom.

- Use one scenario per file
- Don't use helpers for the steps - the only code that calls helpers should be in the test methods
- Use instance variables to pass state, not `let`

## Context

Some applications [like Whitehall](https://github.com/alphagov/whitehall/tree/master/features) use Cucumber to test the logic. This hasn't scaled well, the number of tests make it hard to find where a test step is defined.

## More reading

- [MadeTech: Feature testing with RSpec](https://www.madetech.com/blog/feature-testing-with-rspec)
