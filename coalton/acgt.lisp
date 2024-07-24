(in-package #:acgt)
(named-readtables:in-readtable coalton:coalton)

(coalton-toplevel

  (define-struct ACGT
    (a Integer)
    (c Integer)
    (g Integer)
    (t Integer))

  (define-instance (Semigroup ACGT)
    (define (<> x y)
      (ACGT
        (+ (.a x) (.a y))
        (+ (.c x) (.c y))
        (+ (.g x) (.g y))
        (+ (.t x) (.t y)))))

  (define-instance (Monoid ACGT)
    (define mempty (ACGT 0 0 0 0)))

  (define-instance (Into Char ACGT)
    (define (into c)
      (match c
        (#\A (ACGT 1 0 0 0))
        (#\C (ACGT 0 1 0 0))
        (#\G (ACGT 0 0 1 0))
        (#\T (ACGT 0 0 0 1))
        (_ (ACGT 0 0 0 0)))))

  (define-instance (Into String ACGT)
    (define (into s)
       (iter:fold! <> mempty (map into (str:chars s)))))

  (declare read-file-into-ACGT ((Into :A file:Pathname) => :A -> ACGT))
  (define (read-file-into-ACGT f)
    (into (lisp String (f) (uiop:read-file-string f))))

  (declare read-dir-int-into-ACGT (String -> Integer -> ACGT))
  (define (read-dir-int-into-ACGT d n)
    (read-file-into-ACGT (lisp String (d n) (cl:format nil "~A/~A.acgt" d n))))

  (declare read-all-into-ACGT (String -> Integer -> ACGT))
  (define (read-all-into-ACGT d n)
    (iter:fold! <> mempty (map (read-dir-int-into-ACGT d) (iter:down-from n)))))
