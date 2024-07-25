(defpackage #:acgt
  (:use
    #:coalton
    #:coalton-prelude)
  (:local-nicknames
    (#:cell coalton-library/cell)
    (#:iter coalton-library/iterator)
    (#:file coalton-library/file))
  (:export
    #:ACGT
    #:read-file-into-ACGT
    #:read-dir-int-into-ACGT
    #:read-all-into-ACGT))

(defpackage #:acgt/driver
  (:use #:common-lisp)
  (:export #:main))
