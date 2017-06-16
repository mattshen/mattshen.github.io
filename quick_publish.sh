#!/usr/bin/env bash

# test travis

git add-commit -m "update" && hexo generate && hexo deploy && git push
