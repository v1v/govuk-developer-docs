---
owner_slack: "#govuk-platform-health"
title: Common 2nd line support requests for data.gov.uk
section: data.gov.uk
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2019-03-27
review_in: 6 months
---
[ckan]: https://ckan.publishing.service.gov.uk
[dgu-docs]: https://guidance.data.gov.uk

This document details some of the requests that GOV.UK 2nd line support may receive regarding data.gov.uk.  [Separate documentation][dgu-docs] exists for publishers.

## Users and Publishers
Users have their own accounts and can login using either their username or email address.   A user can be a member of one or more publishing organisations, and can have either the role 'Admin' or 'Editor' for each organisation.  Users with 'Admin' status can add/remove users from the organisation for which they are an admin.  They only have 'admin' rights on their own organisation, contrasted to a 'sysadmin' who has admin rights across all organisations.

### Find a user
There is a [user list](https://ckan.publishing.service.gov.uk/user) which can be used to locate a user account.  This is useful in cases where a publisher does not know their username or no longer has access to their registered email account.  This list is only accessible when logged in as a sysadmin.

### Create a user account
There are two routes for creating an new account for a new user:

1. A publishing organisation's 'admin' user(s) can invite new users to create an account.  The admin user should [follow these instructions](https://guidance.data.gov.uk/publish_and_manage_data/get_and_manage_accounts/#add-or-remove-editors-and-admins) to invite the new user to join. We should encourage this approach as the organisation admin is best placed to know whether or not the new user should have access, as well as reducing the number of requests to 2nd line support.
2. A sysadmin user (e.g. 2nd line) can create an account for the new user. This should only be done if the organisation has no admins, and if we can verify the authenticity of the request.
 - Follow the instructions in [Assign users to publishers](#assign-users-to-publishers-setting-user-permissions) inputting the user's email address instead of their username.
 - An invite email is generated and sent to the publisher.

> An account should only be created if the user intends to publish on data.gov.uk.  Previously users have been able to register accounts to follow publishers.  This is no longer offered.

### Update a user account email address
Since CKAN was upgraded users have needed to login using their email address instead of a username.  Some users have changed their email address and as such are no longer able to login to data.gov.uk. In order to update the email address associated with a user's account:

1. Login to [CKAN][ckan] as a sysadmin user (credentials are available in the `govuk-secrets` password store, under `datagovuk/ckan`).
2. Click the 'Publishers' button in the header.
3. Search for the user's publishing organisation and click on it.
4. Click on the 'Manage' button.
5. Click on the 'Members' tab.
6. Click on the user's username in the list.
7. Click on the 'Manage' button.
8. Fill in the email field with the user's new email address.
9. Enter the password you used to log in to CKAN in the 'Sysadmin password' field.
10. Set a new password for the user.
11. Click 'Update profile'.
12. Reply to the user to tell them that their email address has been changed, what the new password you set is and strongly advise them to change the password when they log in.

### Create a publishing organisation
1. Login to [CKAN][ckan] as a sysadmin user (credentials are available in the `govuk-secrets` password store, under `datagovuk/ckan`).
2. Click the 'Publishers' button in the header.
3. Click 'Add Publisher' and complete the form.
4. Ensure that a publishing user has been assigned as an 'Admin' for this organisation (this would normally be the person who makes the request, so they can then add further 'Editor' users without needing to contact support).

> Check the authenticity of a request before adding a user as a publishing admin (i.e. make sure they actually belong to the department they want to publish for, bearing in mind that some parent organisations may publish on behalf of child organisations, e.g. BEIS can publish for the Civil Nuclear Police Authority).

### Assign users to publishers (setting user permissions)
1. Login to [CKAN][ckan] as a sysadmin user (credentials are available in the `govuk-secrets` password store, under `datagovuk/ckan`).
2. Navigate to the relevant page for the publisher (use the 'Publishers' button in the header).
3. Click the 'Manage' button.
4. Click onto the 'Members' tab, then the 'Add Member' button.
5. Add the user's existing account, or enter their email address to send them an invite, ensuring you select the relevant role for the user (either admin or editor).

> Users should first be guided to request addition by an admin of their organisation, if possible.  This is to reduce the burden of these requests on the 2nd line team and to ensure only those with the correct authority are actually added as publishers.

> Check the authenticity of a request before adding a user as a publisher (i.e. make sure they actually belong to the department they want to publish for, bearing in mind that some parent organisations may publish on behalf of child organisations, e.g. BEIS can publish for the Civil Nuclear Police Authority).

## Datasets
### Delete or withdraw a dataset
Users are not permitted to remove their own datasets.  There are a [limited number of circumstances](https://guidance.data.gov.uk/deleting_datasets.html) in which a dataset will be withdrawn.  This is to be done by 2nd line, following a request from the publisher.  Datasets are never hard-deleted (known as "purged" in CKAN), instead they are marked as "withdrawn" (a soft-deletion), which removes them from the Find interface but allows them to be viewed through the publishing interface (CKAN).

> Before making any deletions, you should check that the person making the request actually belongs to the organisation who own the document (or are from a superseding department, e.g. someone from BEIS could request a withdrawal for a dataset published by BIS).

#### Deleting a single dataset
1. Login to [CKAN][ckan] as a sysadmin user (credentials are available in the `govuk-secrets` password store, under `datagovuk/ckan`).
2. Navigate to the relevant dataset (use the 'Datasets' button in the header).
3. Click the 'Manage' button.
4. Click the red 'Delete' button.
5. Once withdrawn, it will take up to 30 minutes to sync across to Find and clear the cache.

#### Bulk deleting datasets
Sometimes a publisher will request a large deletion of datasets.  In these cases, you can bulk withdraw the datasets using the instructions contained in the [supporting CKAN](/manual/data-gov-uk-supporting-ckan.html#deleting-a-dataset) documentation.  Refer to the instructions for 'Deleting a dataset' (which is a soft-delete).  **Do not purge the dataset - this is a hard-delete.**

### A dataset is wrong in some way
Responsibility for individual datasets lies with the publishing organisation.  Unless it's clearly a data.gov.uk problem (eg, a dataset page is returning an error response when it shouldn't be), users who report a problem with a dataset should be directed to the publisher.

This is a generic response for such cases:

> Thanks for getting in touch.
>
> Individual datasets are the responsibility of the publishing organisation, rather than the data.gov.uk team. This means that you’ll need to get in touch with the publishing organisation directly to request any changes to the dataset.
>
> Contact details for each dataset are towards the bottom of the dataset page.
>
> I hope that helps. I’ll close this ticket now.

## Schema vocabulary definitions
### Add a schema vocabulary definition
Users are not permitted to add their own schema vocabulary definitions.
This is to be done by 2nd line, following a request from the publisher.

1. Add the new schema vocabulary definition to the [schemas](schemas)
2. Add the new schema vocabulary definition to the [corresponding test](test-schemas)

The format is:

```
"<random UUID>": "<schema vocabulary definition title> - <schema vocabulary definition url>"`
```

You can generate a `UUID` in `irb` or `pry`:

```bash
$ pry
[1] pry(main)> require 'securerandom'
=> true
[2] pry(main)> SecureRandom.uuid
=> "14104757-303a-48ad-8eff-bfbe320b0e0a"
```

> **Note**
>
> The added schema will appear in the Schema/Vocabulary dropdown in [https://ckan.publishing.service.gov.uk/dataset/new](https://ckan.publishing.service.gov.uk/dataset/new).

## Harvesting
Harvesting is where publishers can automatically import their data to data.gov.uk without having to manually enter it into the web interface.  They can be set up to run automatically at specified periods, or run manually on-demand.

### Get the status of a harvester
1. Login to [CKAN][ckan] as a sysadmin user (credentials are available in the `govuk-secrets` password store, under `datagovuk/ckan`).
2. Navigate to the relevant harvester (use the 'Harvest' button in the header).
3. You will see a list of the datasets imported by this harvest source.
4. Click the 'Manage' button to get the status.
5. A summary of the current status will be shown.  Individual runs (and the error messages logged) can be access from the 'Jobs' tab.

### Restart a harvester
1. Login to [CKAN][ckan] as a sysadmin user (credentials are available in the `govuk-secrets` password store, under `datagovuk/ckan`).
2. Navigate to the relevant harvester (use the 'Harvest' button in the header).
3. You will see a list of the datasets imported by this harvest source.
4. Click the 'Manage' button.
5. If the harvester is currently running, click the 'Stop' button to stop it.  Once it has stopped, or if it is not currently running, click the 'Reharvest' button.  You will know if the harvester is running because the 'Reharvest' button will be disabled.

## Organogram Publishing
Organograms are files that allow the people structure of an organisation to be visualised.  They are split into two files: one for senior staff (grades SCS1, SCS2 and SCS3, or equivalent) and another for junior staff (all other grades).  The senior staff file is more detailed than the junior staff file, with staff names included for posts classified as grades SCS2 and SCS3.

Organograms are the only datasets in data.gov.uk where we host the data itself rather than linking to an external resource.  The data files are hosted in a S3 bucket (named `datagovuk-integration-ckan-organogram`, `datagovuk-staging-ckan-organogram` or `datagovuk-production-ckan-organogram`, depending on the environment).

Read [publishing organograms](https://guidance.data.gov.uk/publish_and_manage_data/harvest_or_add_data/add_data/#publishing-organograms) to find out how to upload new organograms and datasets. You can direct user queries to that guidance.

### XLS to CSV Conversion
Publishers upload their organograms as a Excel (XLS) file that contains macros.  A script is run which converts these to the two CSV files (junior staff and senior staff).

> Publishers **must** select the correct 'Schema Vocabulary' for their organogram dataset (i.e. one of the two 'organisation structure' values) in order for the upload option to become available and for the XLS-to-CSV conversion to run.

### Dataset Analytics requests
It is possible to access analytics for datasets. If a user requests analytics for datasets, we can provide them with access to an analytics dashboard. Assign tickets like this to Martin Lugton or another member of the Platform Health product team.

## Revision log
There is a [revision log](https://ckan.publishing.service.gov.uk/revision) which shows the most recent edits to CKAN datasets, harvester and users performed by all users.

[schemas]: https://github.com/alphagov/ckanext-datagovuk/blob/master/ckanext/datagovuk/helpers.py#L119-L213
[test-schemas]: https://github.com/alphagov/ckanext-datagovuk/blob/master/ckanext/datagovuk/tests/test_helpers.py#L63-L157
[ckanext-datagovuk]: https://github.com/alphagov/ckanext-datagovuk
