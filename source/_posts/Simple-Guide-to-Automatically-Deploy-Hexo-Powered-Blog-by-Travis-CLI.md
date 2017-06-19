---
title: Simple Guide to Automatically Deploy Hexo Powered Blog by Travis-CLI
tags:
  - Hexo
  - CI
  - Travis-CLI
categories:
  - Continuous Integration
comments: true
date: 2017-06-19 00:00:00
---


This is a guide to simply setup Hexo auto-deployment to github pages by Travis-CLI. 

# Goals
---
* Every time a post is modified or added via github web UI, Travis-CLI would rebuild the whole github page site
* Let Travis-CLI to re-generate Hexo posts and pages
* Let Travis-CLI deploy generated posts and pages to github pages
* Keep sensitive information (here it would be the github personal token) away from public

# Prerequisites
---
* A Github repository with source branch (Hexo project) and master branch (github pages). Here is how it looks like: 

![Github Repository Source Branch](/2017/06/19/Simple-Guide-to-Automatically-Deploy-Hexo-Powered-Blog-by-Travis-CLI/github_source_branch.png)


![Github Repository Master Branch](/2017/06/19/Simple-Guide-to-Automatically-Deploy-Hexo-Powered-Blog-by-Travis-CLI/github_master_branch.png)

* Login Travis-CLI via github account, and allow Travis to access the github repository. 

![Travis Access To Github Repo](/2017/06/19/Simple-Guide-to-Automatically-Deploy-Hexo-Powered-Blog-by-Travis-CLI/travis-access-to-github-repo.png)



# The Setup
---
## The configuration file `.travis.yml`
`.travis.yml` is the file to let Travis know how to build the project. Create one and put it in `source` branch of the git repository

```yaml
language: node_js
node_js:
- stable
branches:
  only:
  - source

install: npm install

before_script:
- git config --global user.name "hexo deployer"
- git config --global user.email "hexo-deployer-lovelywib@gmail.com"
- sed -i "s/__GITHUB_TOKEN__/${__GITHUB_TOKEN__}/" _config.yml

script:
- hexo clean
- hexo g
- hexo d
```

NOTE: We will add `__GITHUB_TOKEN__` environment variable later in Travis

## Give Travis Access to commit generated files to the github's master branch

1. Modify Hexo `_config.yml` deploy URL by adding the `__GITHUB_TOKEN__` string. Here is what it looks like: 

```yaml
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://__GITHUB_TOKEN__@github.com/mattshen/mattshen.github.io.git
  branch: master
```

2. Generate Github Personal access token from github --> personal setting --> Personal access tokens

![Github Personal Token](/2017/06/19/Simple-Guide-to-Automatically-Deploy-Hexo-Powered-Blog-by-Travis-CLI/github_personal_token.png)

NOTE: make sure it has "repo" scope ticked. 

3. Copy the generated token, then create it as environment variable in Travis using name `__GITHUB_TOKEN__`. Here is how it looks like: 

![Travis Environment Variables](/2017/06/19/Simple-Guide-to-Automatically-Deploy-Hexo-Powered-Blog-by-Travis-CLI/travis-env-vars.png)

NOTE: make sure **Display Value in build log** is off, otherwise the secret personal token would be revealed in the build log which is visible to everyone.


## Test
Changes Any file in `source` branch would trigger a Travis build. 

![Travis Builds](/2017/06/19/Simple-Guide-to-Automatically-Deploy-Hexo-Powered-Blog-by-Travis-CLI/travis-builds.png)


# End

After this setup, Travis would be triggered by changes committed to `source` branch, and start building according to `.travis.yml`. 

Have fun with Travis and Hexo Blogging. :)