#!/bin/bash

set -e

s3_path="s3://flomotlik.me"

aws s3 rm $s3_path --recursive
aws s3 cp public $s3_path --recursive --acl public-read
