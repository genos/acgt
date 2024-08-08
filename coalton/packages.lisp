(defpackage #:acgt
  (:use
    #:coalton
    #:coalton-prelude)
  (:local-nicknames
    (#:cell coalton-library/cell)
    (#:file coalton-library/file)
    (#:iter coalton-library/iterator)
    (#:list coalton-library/list)
    (#:str  coalton-library/string)
    (#:sys  coalton-library/system))
  (:export #:main))

(defpackage #:acgt/driver
  (:use #:common-lisp)
  (:export #:main))
