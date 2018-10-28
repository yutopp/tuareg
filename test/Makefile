EMACS ?= emacs
DIFF ?= diff

TESTS = $(wildcard *.ml)
TEST_DIFF = $(foreach x, $(TESTS), $(x).diff)

.PHONY: generate-diff diff-test

diff-test: generate-diff $(TEST_DIFF)
	script/count.sh

generate-diff:
	@echo $(TESTS) | \
	  emacs --batch --quick --load ../yuareg-site-file.el --load script/generate-diff.el 2>/dev/null
