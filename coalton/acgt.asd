(asdf:defsystem #:acgt
  :depends-on (#:coalton #:uiop)
  :serial t
  :components ((:file "packages")
               (:file "acgt")))

(asdf:defsystem #:acgt/driver
  :depends-on (#:acgt #:uiop)
  :serial t
  :components ((:file "driver"))
  :build-operation "program-op"
  :build-pathname "acgt"
  :entry-point "acgt/driver:main")
