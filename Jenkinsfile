#!/usr/bin/env groovy

library("govuk")

REPOSITORY = 'govuk-developer-docs'

node {
    stage("Checkout") {
      govuk.checkoutFromGitHubWithSSH(REPOSITORY, [org: 'v1v'])
      sh 'env | sort'
    }
    stage("Lint documentation") {
      sh '''
        whereis python
        which python
        python --version
        curl https://pre-commit.com/install-local.py | python -
        git diff-tree --no-commit-id --name-only -r $(git rev-parse HEAD) | xargs pre-commit run --files | tee pre-commit-report.txt
      '''
    }

}
