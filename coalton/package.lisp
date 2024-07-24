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
    #:read-file-into-ACGT
    #:read-dir-int-into-ACGT
    #:read-all-into-ACGT))
