.PHONY: all clean
LISP ?= sbcl

all: acgt

acgt: acgt.asd acgt.lisp package.lisp
	$(LISP) --load acgt.asd \
		--eval '(ql:quickload :acgt)' \
		--eval '(asdf:make :acgt)' \
		--eval '(quit)'

clean:
	rm acgt
