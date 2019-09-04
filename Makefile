all: lint

lint:
	shellcheck is-everything-pushed.sh
