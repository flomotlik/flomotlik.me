.PHONY: css css-min clean build serve

css:
	mkdir -p static/css
	lessc css/less/main.less static/css/main.css
	cp css/*.css static/css

css-min:
	mkdir -p static/css
	lessc --clean-css css/less/main.less static/css/main.css
	cp css/*.css static/css

clean:
	rm -rf static/css
	rm -rf public

build: clean css
	hugo --minify

serve:
	hugo server --bind 0.0.0.0 --baseURL http://localhost:1313 --disableFastRender
