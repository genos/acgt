(in-package #:acgt/driver)

(defun main ()
  (declare (optimize (speed 3) (safety 0) (space 3) (debug 0)))
  (let ((args (uiop:command-line-arguments)))
    (uiop:println (acgt:read-all-into-ACGT (first args) (parse-integer (second args))))
    (uiop:quit)))
