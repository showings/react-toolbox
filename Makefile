MAKEFLAGS = -j1

export NODE_ENV = test

bootstrap:
	make clean-all
	yarn
	./node_modules/.bin/lerna bootstrap

clean-all:
	rm -rf packages/*/lib
	rm -rf node_modules
	rm -rf packages/*/node_modules
	make clean

clean:
	rm -rf coverage
	rm -rf packages/*/npm-debug*

test-only:
	./scripts/test.sh
	make test-clean

test-ci:
	make bootstrap
	make test
  make lint

test:
	node --harmony_proxies node_modules/.bin/jest

test-watch:
	node --harmony_proxies node_modules/.bin/jest --watch --no-watchman

prettier:
	prettier --write --single-quote --trailing-comma=es5 \"packages/react-toolbox-core/src/**/*.js\"

lint:
  make lint-js
  make lint-css

lint-js:
	./node_modules/.bin/eslint scripts packages *.js --format=codeframe

lint-css:
	./node_modules/.bin/stylelint packages/*/src/**/*.css

fix:
	./node_modules/.bin/eslint scripts packages *.js --format=codeframe --fix
