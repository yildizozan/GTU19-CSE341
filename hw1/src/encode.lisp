; *********************************************
; *  341 Programming Languages                *
; *  Fall 2019                                *
; *  Author: Ozan Yıldız                      *
; *  BONUS PART                               *
; *********************************************

;; utility functions 
(load "include.lisp") ;; "c2i and "i2c"

(defun get-position (letter list)
    (position letter list :test #'equal)
)

(defun get-char (pos list)
    (nth (mod (+ *encryption-index* pos) 26) list)
)

(defun encode (word)
    (if word (mapcar (lambda (it) (get-char (get-position it *valid-chars*) *valid-chars*)) word) )
)

(defun encoder (filename)
	(let ((accumulator '()))
		(let ((in (open filename :if-does-not-exist nil)))
			(when in
				(loop for line = (read-line in nil)
					while line do (setf accumulator (append accumulator (mapcar (lambda (it) (encode it)) (line-to-list line))  ))
				)
				(close in)
			)
		)
		accumulator))

;; -----------------------------------------------------
;; Test code...
(defun test_on_test_data ()
	(print "....................................................")
	(print "Testing ....")
	(print "....................................................")
	(terpri)
	(princ (encoder "document1.txt"))
)

;; test code...
(test_on_test_data)