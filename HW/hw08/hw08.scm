(define (ascending? s) 
    (cond 
        ((or (null? s) (null? (cdr s))) #t)
        ((<= (car s) (car (cdr s))) (ascending? (cdr s)))
        (else #f))
        
)

(define (my-filter pred s) 
    (cond
        ((null? s) nil)
        ((pred (car s)) (append (list (car s)) (my-filter pred (cdr s))))
        (else (append (my-filter pred (cdr s))))
    )
)

(define (interleave lst1 lst2) 
    (cond
        ((and (null? lst2) (null? lst1)) nil)
        ((null? lst1) lst2)
        ((null? lst2) lst1)
        (else (append (list (car lst1)) (list (car lst2)) (interleave (cdr lst1) (cdr lst2))))
    )
)

(define (helper x s)
    (cond
        ((null? s) #t)
        ((= x (car s)) #f)
        (else (helper x (cdr s)))
    )    
)

(define (no-repeats s)
    (cond
        ((null? s) nil)
        ((helper (car s) (no-repeats (cdr s))) (append (list (car s)) (no-repeats (cdr s))))
        (else (append (no-repeats (cdr s))))
    )
)

;;; (my-filter even? '(1 2 3 4))
;;; (no-repeats '(5 4 3 2 1))

; (define (no-repeats s)
;   (if (null? s) s
;     (cons (car s)
;       (no-repeats (filter (lambda (x) (not (= (car s) x))) (cdr s)))))
; )