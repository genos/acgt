(asdf:defsystem #:acgt
  :depends-on (#:coalton #:uiop)
  :serial t
  :components ((:file "package")
               (:file "acgt")))
