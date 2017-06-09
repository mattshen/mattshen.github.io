#!/usr/bin/env bash

git add-commit -m "update" && hexo generate && hexo deploy && git push
