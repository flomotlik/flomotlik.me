.PHONY: css clean prepare deploy

css: clean
	#lessc css/less/reset.less static/css/reset.css
	# lessc css/less/pygments.less static/css/pygments.css
	lessc css/less/main.less static/css/main.css
	cp css/*.css static/css

clean:
	rm -rf static/css
	rm -rf public

prepare:
	hugo

deploy: clean css prepare
	aws s3 sync public s3://flomotlik.me --acl public-read --delete
