EMACS ?= emacs
DIFF ?= diff

TESTS = $(wildcard *.ml)
TEST_DIFF = $(foreach x, $(TESTS), $(x).diff)

diff-test: generate-diff $(TEST_DIFF)
	@fail=0; \
	success=0; \
	for f in *.diff; do         \
	  if [ ! -s $${f} ]; then   \
	   success=`expr $${success} + 1`; \
	  else                      \
	   fail=`expr $${fail} + 1`; \
	  fi                        \
	done;                       \
	echo "total: " `expr $$fail + $$success` " success: " $${success} " failed: " $${fail}; \
	if [ -z $${fail} ]; then return 0; else return 1; fi

.PHONY: generate-diff

generate-diff:
	@echo $(TESTS) | \
	  emacs --batch --quick --load ../yuareg-site-file.el --load generate-diff.el 2>/dev/null
