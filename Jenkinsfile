#!/usr/bin/env groovy

library("govuk")

REPOSITORY = 'govuk-developer-docs'

node {
    stage("Checkout") {
      govuk.checkoutFromGitHubWithSSH(REPOSITORY, [org: 'v1v'])
      sh 'env | sort'
    }

    stage("Merge master") {
      govuk.mergeMasterBranch()
    }

    stage("Lint documentation") {
      sh """
        env | sort
        curl https://pre-commit.com/install-local.py | python -
        git diff-tree --no-commit-id --name-only -r ${commit} | xargs pre-commit run --files | tee ${reportFileName}
      """
    }

}
