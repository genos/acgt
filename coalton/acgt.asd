(asdf:defsystem #:acgt
  :depends-on (#:coalton)
  :serial t
  :components ((:file "packages")
               (:file "acgt")))

(asdf:defsystem #:acgt/driver
  :depends-on (#:acgt #:coalton)
  :serial t
  :components ((:file "packages")
               (:file "acgt"))
  :build-operation "program-op"
  :build-pathname "acgt"
  :entry-point "acgt/driver:main")
