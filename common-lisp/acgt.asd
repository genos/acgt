(asdf:defsystem #:acgt
  :depends-on (#:uiop #:lparallel)
  :serial t
  :components ((:file "package")
               (:file "acgt"))
  :build-operation "program-op"
  :build-pathname "acgt"
  :entry-point "acgt:main")
