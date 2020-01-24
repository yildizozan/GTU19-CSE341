; *********************************************
; *  341 Programming Languages                *
; *  Fall 2019                                *
; *  Author: Yakup Genc                       *
; *********************************************

;; utility functions 
(load "include.lisp") ;; "c2i and "i2c"

;; -----------------------------------------------------
;; Bonus Part: Encoder
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

(defun read-as-list (filename)
	(let ((accumulator '()))
		(let ((in (open filename :if-does-not-exist nil)))
			(when in
				(loop for line = (read-line in nil)
					while line do (setf accumulator (append accumulator (line-to-list line)))
				)
				(close in)
			)
		)
		accumulator
	)
)


;; -----------------------------------------------------
;; HELPERS
;; *** PLACE YOUR HELPER FUNCTIONS BELOW ***

(defun spell-checker-0 (word)
	(princ word)
	(let ((*success* nil))
		(let ((in (open "dictionary1.txt" :if-does-not-exist nil)) )
		(when in
			(loop for line = (read-line in nil)
				until (eql t *success*)
				while line do (if (equalp word (coerce line 'list)) (setf *success* t))
			)
			(close in)	
		)
		)
	*success*
	)
)

(defun spell-checker-1 (word)
	(let ( (*temp-map* (make-hash-table)) )
		(setf (gethash '#\e *temp-map*) 12.02)
		(setf (gethash '#\t *temp-map*) 9.10)
		(setf (gethash '#\a *temp-map*) 8.12)
		(setf (gethash '#\i *temp-map*) 7.31)
		(setf (gethash '#\o *temp-map*) 7.68)
		(loop while (not nil)
			do (let ( (*temp-map* (generate-hashmap)) )
				(mapcar (lambda (it) (spell-checker-0 (convert it *temp-map*)) ) paragraph)
			)	
		)
	)
)

;; -----------------------------------------------------
;; DECODE FUNCTIONS

(defun Gen-Decoder-A (paragraph)
	(loop while (not nil)
		do (let ( (*temp-map* (generate-hashmap)) )
				(mapcar (lambda (it) (spell-checker-0 (convert it *temp-map*)) ) paragraph)
			)	
	)
)

(defun Gen-Decoder-B-0 (paragraph)
	(mapcar (lambda (it) (if it (spell-checker-1 it) ) ) paragraph)
)

(defun Gen-Decoder-B-1 (paragraph)
  	;you should implement this function
)

(defun Code-Breaker (document decoder)
  	;you should implement this function
)

;; -----------------------------------------------------
;; Test code...
(defun test_on_test_data ()
	(print "....................................................")
	(print "Testing ....")
	(print "....................................................")
	(terpri)
	(let ((doc (read-as-list "document1.txt")))
		(princ doc)
	)	

	(print "....................................................")
	(print "Testing Gen-Decoder-A....")
	(print "....................................................")
	(terpri)
	(princ (Gen-Decoder-A '((#\y #\v #\c #\c #\f) (#\k #\v #\j #\k) (#\r) (#\z #\j) (#\k #\y #\z #\j)) ))

	(print "....................................................")
	(print "Testing Gen-Decoder-B-0....")
	(print "....................................................")
	(terpri)
	;(princ (Gen-Decoder-B-0 '((#\y #\v #\c #\c #\f) (#\k #\v #\j #\k) (#\r) (#\z #\j) (#\k #\y #\z #\j)) ))
)

;; test code...
(test_on_test_data)
