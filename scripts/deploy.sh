#!/bin/bash

set -e

rm -fr public

hugo

s3_path="s3://flomotlik.me"

# aws s3 rm $s3_path --recursive
aws s3 sync public $s3_path --acl public-read --delete
