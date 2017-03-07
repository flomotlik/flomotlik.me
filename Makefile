.PHONY: css clean prepare deploy

css: clean
	lessc css/less/main.less static/css/main.css
	cp css/*.css static/css

clean:
	rm -rf static/css
	rm -rf public

build:
	hugo

deploy: clean css build
	aws s3 sync public s3://flomotlik.me --acl public-read --delete
