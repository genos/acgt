.PHONY: all clean
LISP ?= sbcl
MODE ?= releae

all: acgt

acgt: acgt.asd acgt.lisp packages.lisp
	COALTON_ENV=$(MODE) $(LISP) --load acgt.asd \
		--eval '(ql:quickload :coalton)' \
		--eval '(ql:quickload :acgt)' \
		--eval '(asdf:make :acgt/driver)' \
		--eval '(quit)'

clean:
	rm acgt
