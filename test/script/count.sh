#!/bin/bash -ue

fail=0
success=0

for f in *.diff; do
    if [ ! -s ${f} ]; then
	success=`expr ${success} + 1`
    else
	fail=`expr ${fail} + 1`
    fi
done

echo "total: " `expr $fail + $success` " success: " ${success} " failed: " ${fail}
if [ -z ${fail} ]; then exit 0; else exit 1; fi
