(defparameter *valid-chars* '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z))
(defparameter *my-hash* (make-hash-table))
(defparameter *letter-mapping* (make-hash-table))
(defvar *used-letters* (make-hash-table))
(setf (gethash '#\a *used-letters*) nil)
(setf (gethash '#\b *used-letters*) nil) 
(setf (gethash '#\c *used-letters*) nil) 
(setf (gethash '#\d *used-letters*) nil)
(setf (gethash '#\e *used-letters*) nil)
(setf (gethash '#\f *used-letters*) nil) 
(setf (gethash '#\g *used-letters*) nil) 
(setf (gethash '#\h *used-letters*) nil) 
(setf (gethash '#\i *used-letters*) nil)
(setf (gethash '#\j *used-letters*) nil) 
(setf (gethash '#\k *used-letters*) nil) 
(setf (gethash '#\l *used-letters*) nil) 
(setf (gethash '#\m *used-letters*) nil) 
(setf (gethash '#\n *used-letters*) nil) 
(setf (gethash '#\o *used-letters*) nil)
(setf (gethash '#\p *used-letters*) nil) 
(setf (gethash '#\q *used-letters*) nil) 
(setf (gethash '#\r *used-letters*) nil) 
(setf (gethash '#\s *used-letters*) nil) 
(setf (gethash '#\t *used-letters*) nil)
(setf (gethash '#\u *used-letters*) nil) 
(setf (gethash '#\v *used-letters*) nil) 
(setf (gethash '#\w *used-letters*) nil) 
(setf (gethash '#\x *used-letters*) nil) 
(setf (gethash '#\y *used-letters*) nil) 
(setf (gethash '#\z *used-letters*) nil) 

(defvar *text* '())

(defun read-as-list (filename)
    (let ((in (open filename :if-does-not-exist nil)))
        (when in
            (loop for line = (read-line in nil)
                while line do (format t "~a~%" line))
            (close in)))
)

;(print (read-as-list "./doc3.txt"))

(setf (gethash 'one-entry *my-hash*) "one")
(gethash 'one-entry *my-hash*)

(setf (gethash 'another-entry *my-hash*) 2/4)
(gethash 'another-entry *my-hash*)

;;;;;;;;;;;;;;;;;;;;;;;
(defun letter-freq (file)
    (with-open-file (stream file)
        (let ((str (make-string (file-length stream)))
            (ht (make-hash-table)))
        (read-sequence str stream)
        (loop :for char :across str :do
            (incf (gethash char ht 0)))
        (maphash (lambda (k v)
                    (format t "~@C: ~D~%" k v))
                ht)
        )
    )
)
(letter-freq "doc3.txt")

;;;;;;;;;;;;;;;;;;;;;;;

(defun read-recursive (stream-in stream-out)
  (let ((char (read-char stream-in nil)))
    (unless (null char)
      (format stream-out "~c" char)
      (read-recursive stream-in stream-out))))

(defun read-file (infile)
  (with-open-file (instream infile :direction :input :if-does-not-exist nil)
    (when instream 
      (let ((string (make-string (file-length instream))))
        (read-sequence string instream) string))))

;(print (read-file "doc3.txt"))

(map 'list #'- '(1 2 3 4))
(print (map 'list #'- '(1 2 3 4)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun factorial (N)
    "Compute the factorial of N."
    (if (= N 1)
        1
        (* N (factorial (- N 1)))
    )
)
(print (factorial 5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Searching

(defun mem (E L)
    (if (null L)
        nil
        (if (equal (first L) E)
            T
            (mem E (rest L))
        )
    )
)
;(print (mem 'A '(B A G)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Copying a list
(defun copylist (L)
    (if (null L)
        nil
        (cons (first L)(copylist (rest L)))
    )
)
(format t "CopyList ~a" (eq '(A B C) (copylist '(A B C))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Copying a list
(defun my-append (L1 L2)
    (if (null L1)
        L2
        (cons (first L1)
            (my-append (rest L1) L2)
        )
    )
)
(format t "Append ~a~%" (my-append '(a b c) '(d e f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Copying a list
(defun my-reverse(l)
    (if (null l) l 
        (my-append (my-reverse ( cdr l)) (list (car l)))
    )
)
(format t "Reverse ~a~%" (my-reverse '(1 2 3 4 5)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Copying a list
(terpri)
(defvar *map* (make-hash-table))
(setf (gethash '#\a *map*) 8.12) 
(setf (gethash '#\b *map*) 1.49) 
(setf (gethash '#\c *map*) 2.71) 
(setf (gethash '#\d *map*) 4.32)
(setf (gethash '#\e *map*) 12.02)
(setf (gethash '#\f *map*) 2.30) 
(setf (gethash '#\g *map*) 2.03) 
(setf (gethash '#\h *map*) 5.92) 
(setf (gethash '#\i *map*) 7.31)
(setf (gethash '#\j *map*) 0.10) 
(setf (gethash '#\k *map*) 0.69) 
(setf (gethash '#\l *map*) 3.98) 
(setf (gethash '#\m *map*) 2.61) 
(setf (gethash '#\n *map*) 6.95) 
(setf (gethash '#\o *map*) 7.68)
(setf (gethash '#\p *map*) 1.82) 
(setf (gethash '#\q *map*) 0.11) 
(setf (gethash '#\r *map*) 5.99) 
(setf (gethash '#\s *map*) 6.28) 
(setf (gethash '#\t *map*) 9.10)
(setf (gethash '#\u *map*) 2.88) 
(setf (gethash '#\v *map*) 1.11) 
(setf (gethash '#\w *map*) 2.09) 
(setf (gethash '#\x *map*) 0.17) 
(setf (gethash '#\y *map*) 2.11) 
(setf (gethash '#\z *map*) 0.07) 
;(maphash #'(lambda (k v) (print (list k v))) a)
(maphash (lambda (k v) (format t "~@A: ~D~%" k v)) *map*)


(defun line-to-list (str)
  (let (retlist '() )
    (loop
        (setq retval (find-first-index str))
        ;(write retval)

        (when (= retval 0) 
            (return retlist)
        )

        (if (<= (length str ) retval)
            (progn 
                (push (coerce str 'list) retlist)
                (return retlist)
            )
            (push (coerce (subseq str 0 retval) 'list) retlist)
        )    
        (setq str (subseq str (+ 1 retval)))
    )
  )
)


(defun find-first-index (str)
  (if  (string= str "")
    0
    (progn  
      (if (or  (eq (char str 0) #\tab) (eq (char str 0) #\Space) (eq (char str 0) #\linefeed)) 
        0                                             
        (progn                                                                           
          (if (eq (char str 0) #\) )                                                         
            0  
            (+ 1 (find-first-index (subseq str 1)))                                       
        )                                         
      )
    )
  )
))

(defun read-as-list-v2 (filename)
    (let ((in (open filename :if-does-not-exist nil)))
        (when in
            (loop for line = (read-line in nil)
                while line do (format t "~a ~%" (line-to-list line))
            )
            (close in)
        )
    )
)

;(format t "~a ~%" (append '(1) (line-to-list "merhaba dünya") ))
;(format t "~a ~%" (read-as-list-v2 "doc3.txt") )

;; Accumulator
(defun mycollect (func args num)
  (let ((accumulator '()))     ; it's a null list. 
    (loop for i from 1 to num 
      do
	  (setf accumulator                   
        (cons (apply func args) accumulator))) accumulator)
)

;; Check-in Dictionary
(defun is-in-list (word list_to_search)
  (if (not (null list_to_search))
    (dolist (n list_to_search)
      (if (equal word n)(return-from isInList t)))
    nil
  )
)

(defun string-to-list (s) (coerce s 'list))
  
(defun check-in-dictionary (word)
	(let (result)
		(let ((in (open "dictionary1.txt" :if-does-not-exist nil)))
			(when in
				(loop for line = (read-line in nil)
					;while line do (setf result (equal (line-to-list line) word) )
                    while line do (format t "~a=~a ~a ~%" word (coerce line 'list) (equalp word (coerce line 'list)) )
				)
				(close in)
			)
		)

		result)
)

;; Recursive list
(defun print-elements-recursively (list)
       "Print each element of LIST on a line of its own.
     Uses recursion."
       (when list                            ; do-again-test
             (print (car list))              ; body
             (print-elements-recursively     ; recursive call
              (cdr list))))                  ; next-step-expression
            

(setq *paragraph* '((h e l l o)(t h i s)(i s)(a)(t e s t)(d i c t i o n a r y)))
(setq *word* '(#\h #\e #\l #\l #\o) )
(print (check-in-dictionary  *word*))

(terpri)
;(8print-elements-recursively *paragraph*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(terpri)
(defun random-password (length)
  (let ((chars "abcdefghijklmnopqrstuvwxyz"))
    (coerce (loop repeat length collect (aref chars (random (length chars))))
            'string)))

;(print (random-password 6))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(terpri)
; Return random valid char
(defun random-char (list)
    (nth (random (length list)) list)
)

(defun my-encrypt (text)
    (loop for i from 0 to 26
        do (let ((*random-letter* (random-char *valid-chars*)) (*success* nil) )
            (loop while (not *success*)
                until (null *success*)

                ;do (format t "~a~%" *random-letter*)
            )
        )
    )
)

(defparameter *encryption-index* 3)

(defun get-char (list)
    (nth (mod 3 26) list)
)

(defun my-encrypt-v2 (text)
    (loop for i from 0 to 26
        do (

        )
    )
)

(my-encrypt '(h e l l o))

;; -----------------------------------------------------
;; Bonus Part: Encoder
(defparameter *encryption-index* (random 101))

(defun get-position (letter list)
    (position letter list :test #'equal)
)

(defun get-char (pos list)
    (nth (mod (+ *encryption-index* pos) 26) list)
)

(defun encode (word)
    ;(mapcar (lambda (it) (princ it)) word)
    (if word (mapcar (lambda (it) (get-char (get-position it *valid-chars*) *valid-chars*)) word) )
)

(defun read-as-list (filename)
	(let ((accumulator '()))
		(let ((in (open filename :if-does-not-exist nil)))
			(when in
				(loop for line = (read-line in nil)
					while line do (setf accumulator (append accumulator (mapcar (lambda (it) (encode it)) (line-to-list line))  ))
				)
				(close in)
			)
		)
		accumulator
	)
)

;(princ (encode nil))
(terpri)
;(princ (encode '(#\h #\e #\l #\l #\o)))
(terpri)
(princ (read-as-list "document1.txt"))


;; -----------------------------------------------------
;; Swap
(terpri)
(defvar *swap-map* (make-hash-table))
(setf (gethash '#\y *swap-map*) '#\h) 
(setf (gethash '#\v *swap-map*) '#\e) 
(setf (gethash '#\c *swap-map*) '#\l) 
(setf (gethash '#\f *swap-map*) '#\o)

(defun convert (*word* *hashmap*) 
    (let ((*new* '()))
        (mapcar (lambda (*it*) (append *new* (gethash *it* *hashmap*)) ) *word* )
    )
)

(princ (convert '(#\y #\v #\c #\c #\f) *swap-map*))

;; -----------------------------------------------------
;; Swap
(terpri)
(format t "-- Generate HashMap")
(terpri)

(defun get-random-letter (*list*)
    (nth (random (length *list*)) *list*)
)

(defun generate-hash ()
    (let ( (*letters* '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z)) (*new-list* '()) (*new-hashmap* (make-hash-table)) )
        (loop for i from 0 to 25
            do (let ((*letter* (get-random-letter *letters*)) )
                ;(setf (gethash it *new-hashmap*) *letter*)
                (setf *new-list* (append (list *letter*) *new-list*))
                (setf *letters* (remove *letter* *letters*))
            )
        )
        (loop for i from 0 to 25
            do (setf (gethash (nth i *valid-chars*) *new-hashmap*) (nth i *new-list*)) 
        )
        *new-hashmap*
    )
)

(princ (generate-hash))

