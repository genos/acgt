(defpackage #:acgt
  (:use
    #:coalton
    #:coalton-prelude)
  (:local-nicknames
    (#:iter coalton-library/iterator)
    (#:file coalton-library/file)
    (#:str coalton-library/string))
  (:export
    #:ACGT
    #:.a #:.c #:.g #:.t
    #:read-file-into-ACGT
    #:read-dir-int-into-ACGT
    #:read-all-into-ACGT))

(defpackage #:acgt/driver
  (:use #:common-lisp)
  (:export #:main))
