(in-package #:acgt)

(declaim (optimize (speed 3) (safety 0) (space 0) (debug 0)))

(defstruct acgt
  (a 0 :type fixnum)
  (c 0 :type fixnum)
  (g 0 :type fixnum)
  (t 0 :type fixnum))

(declaim (ftype (function (acgt acgt) acgt) <>))
(defun <> (x y)
  (make-acgt
    :a (the fixnum (+ (acgt-a x) (acgt-a y)))
    :c (the fixnum (+ (acgt-c x) (acgt-c y)))
    :g (the fixnum (+ (acgt-g x) (acgt-g y)))
    :t (the fixnum (+ (acgt-t x) (acgt-t y)))))

(declaim (ftype (function (simple-string) acgt) string->acgt))
(defun string->acgt (s)
  (loop :for c :across s
        :count (eql #\A c) :into as
        :count (eql #\C c) :into cs
        :count (eql #\G c) :into gs
        :count (eql #\T c) :into ts
        :finally (return (make-acgt :a as :c cs :g gs :t ts))))

(declaim (ftype (function (string) acgt) file->acgt))
(defun file->acgt (f)
  (string->acgt (uiop:read-file-string f)))

(declaim (ftype (function (string fixnum) acgt) dir-int->acgt))
(defun dir-int->acgt (d n)
  (file->acgt (format nil "~A/~A.acgt" d n)))

(declaim (ftype (function (string fixnum) acgt) read-all-into-acgt))
(defun read-all-into-acgt (d n)
  (lparallel:preduce
    #'<>
    (lparallel:pmap
      'vector
      #'(lambda (i) (dir-int->acgt d i))
      (loop :for i fixnum :below n :collect i))))

(defun main ()
  (let* ((args (uiop:command-line-arguments))
         (d (or (first args) "../data"))
         (n (parse-integer (or (second args) "20000")))
         (cs (parse-integer (or (third args) "16"))))
    (setf lparallel:*kernel* (lparallel:make-kernel cs))
    (uiop:println (acgt:read-all-into-ACGT d n))
    (uiop:quit)))
