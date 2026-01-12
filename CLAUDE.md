# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal website for Florian Motlik built with Hugo static site generator. Hosted on GitHub Pages with AWS infrastructure managed via Formica.

## Commands

### Development
- `hugo server` - Start local development server at http://localhost:1313/ with live reload
- `make css` - Compile Less CSS (css/less/main.less → static/css/main.css)
- `make build` - Full build: clean, compile CSS, generate site
- `make clean` - Remove build artifacts (static/css and public directories)

### Prerequisites
- **Hugo** - Static site generator
- **lessc** - Less CSS compiler (`npm install -g less`)
- **AWS CLI** - For infrastructure deployment

## Architecture

### Content
- `content/` - Markdown content (blog posts, pages)
- `content/blog/` - Blog posts with frontmatter (title, date, slug)
- `content/how-i/` - "How I" series articles

### Templates
- `layouts/` - Hugo templates
- `layouts/partials/` - Reusable components (header, footer, head_includes)
- `layouts/index.html` - Homepage
- `layouts/section/blog.html` - Blog listing page

### Styling
- `css/less/` - Less source files
- `css/less/main.less` - Main entry point (imports site.less, markdown.less)
- `static/css/` - Compiled CSS output

### Infrastructure
- `flomotlik.me.template.yaml` - Formica template for AWS (Route53, S3, redirects)
- `modules/formica/` - Git submodule with Formica infrastructure modules

### Configuration
- `config.toml` - Hugo config (baseURL, permalinks, social params)
- Permalinks: `/blog/:slug/`
