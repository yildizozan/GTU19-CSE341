; *********************************************
; *  341 Programming Languages                *
; *  Fall 2018                                *
; *  Author: Yakup Genc                       *
; *********************************************
(defparameter *encryption-index* (random 101))
(defparameter *my-list* '())
(defparameter *valid-chars* '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z))
(defvar *encrypted-data-frequency* (make-hash-table))
(defvar *english-frequency* (make-hash-table))
(setf (gethash '#\a *english-frequency*) 8.12) 
(setf (gethash '#\b *english-frequency*) 1.49) 
(setf (gethash '#\c *english-frequency*) 2.71) 
(setf (gethash '#\d *english-frequency*) 4.32)
(setf (gethash '#\e *english-frequency*) 12.02)
(setf (gethash '#\f *english-frequency*) 2.30) 
(setf (gethash '#\g *english-frequency*) 2.03) 
(setf (gethash '#\h *english-frequency*) 5.92) 
(setf (gethash '#\i *english-frequency*) 7.31)
(setf (gethash '#\j *english-frequency*) 0.10) 
(setf (gethash '#\k *english-frequency*) 0.69) 
(setf (gethash '#\l *english-frequency*) 3.98) 
(setf (gethash '#\m *english-frequency*) 2.61) 
(setf (gethash '#\n *english-frequency*) 6.95) 
(setf (gethash '#\o *english-frequency*) 7.68)
(setf (gethash '#\p *english-frequency*) 1.82) 
(setf (gethash '#\q *english-frequency*) 0.11) 
(setf (gethash '#\r *english-frequency*) 5.99) 
(setf (gethash '#\s *english-frequency*) 6.28) 
(setf (gethash '#\t *english-frequency*) 9.10)
(setf (gethash '#\u *english-frequency*) 2.88) 
(setf (gethash '#\v *english-frequency*) 1.11) 
(setf (gethash '#\w *english-frequency*) 2.09) 
(setf (gethash '#\x *english-frequency*) 0.17) 
(setf (gethash '#\y *english-frequency*) 2.11) 
(setf (gethash '#\z *english-frequency*) 0.07) 

(defun c2i (x)
	; Convert character to int.
	(- (char-int x) (char-int #\a))
)


(defun i2c (x)
	; Convert int to character.
	(int-char (+ x (char-int #\a)))
)

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
        (setq str (subseq str (+ 1 retval))))))


(defun find-first-index (str)
  (if  (string= str "")
    0
    (progn  
      (if (or  (eq (char str 0) #\tab) (eq (char str 0) #\Space) (eq (char str 0) #\linefeed)) 
        0                                             
        (progn                                                                           
          (if (eq (char str 0) #\) )                                                         
            0  
            (+ 1 (find-first-index (subseq str 1)))))))))

; Convert encrypted text to normal (normalizasyon)
(defun convert (*word* *hashmap*) 
    (let ((*new* '()))
        (mapcar (lambda (*it*) (append *new* (gethash *it* *hashmap*)) ) *word* )
    )
)

; Get random element from list
(defun get-random-letter (*list*)
    (nth (random (length *list*)) *list*)
)


(defun generate-hashmap ()
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
