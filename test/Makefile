EMACS ?= emacs
DIFF ?= diff

TESTS = $(wildcard *.ml)
TEST_GENERATED = $(foreach x, $(TESTS), $(x).generated.test)
TEST_DIFF = $(foreach x, $(TESTS), $(x).diff)

diff-test: $(TEST_DIFF)
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

.PHONY: refresh

refresh:

%.diff: %.generated.test
	@$(DIFF) $* $< > $@ || echo $@ "\n" "`cat $@`"

%.generated.test: % refresh
	@$(EMACS) --batch -q --no-site-file $(ENABLE_SMIE) \
	  --load ../yuareg-site-file.el $< \
	  --eval '(setq indent-tabs-mode nil)' \
	  --eval '(defun ask-user-about-lock (file opponent) nil)' \
	  --eval '(indent-region (point-min) (point-max) nil)' \
	  --eval '(indent-region (point-min) (point-max) nil)' \
	  --eval '(write-region (point-min) (point-max) "$@")' 2>/dev/null
