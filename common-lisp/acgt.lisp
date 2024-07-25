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
        :counting (eql #\A c) :into as
        :counting (eql #\C c) :into cs
        :counting (eql #\G c) :into gs
        :counting (eql #\T c) :into ts
        :finally (return (make-acgt :a as :c cs :g gs :t ts))))

(declaim (ftype (function (string) acgt) file->acgt))
(defun file->acgt (f)
  (string->acgt (uiop:read-file-string f)))

(declaim (ftype (function (string fixnum) acgt) dir-int->acgt))
(defun dir-int->acgt (d n)
  (file->acgt (format nil "~A/~A.acgt" d n)))

(declaim (ftype (function (string fixnum) acgt) read-all-into-acgt))
(defun read-all-into-acgt (d n)
  (loop :for i fixnum :below n
        :with x = (make-acgt)
        :do (setf x (<> x (dir-int->acgt d i)))
        :finally (return x)))
