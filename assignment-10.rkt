;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-10) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;*****************************
;; Assignment 10 (2025/05/19)
;; 1TE24053S Shiota Sora
;;*****************************


;; reduce : (X Y -> Y) Y (listof X) -> Y
;; reduces list of X into the list of Y using operator(X Y -> Y),
;; **from last to the first**
;; eg. (reduce g 0 (list 1 2 3)) => (g 1 (g 2 (g 3 0)))
;;     (reduce + 0 (list 1 2 3)) => (+ 1 (+ 2 (+ 3 0))) => 6
(define (reduce op base L)
  (cond
    [(empty? L) base]
    [else (op (first L) (reduce op base (rest L)))]))


;;======
;; Q1
;;======
;; copy-list : (listof X) -> (listof X)
;; generates the shallow copy of the given list
;; eg. (copy-list (list 1 2 3)) => (list 1 2 3)
(define (copy-list L)
  (reduce cons empty L))

;; test
(copy-list (list 1 2 3)) ;; => (list 1 2 3)
(copy-list empty) ;; => empty


;;======
;; Q2
;;======
;; sqr-list : (listof number) -> (listof number)
;; generateßthe squared number list of the given list of number
;; eg. (sqr-list (list 1 2 3)) => (list 1 4 9)
(define (sqr-list L)
  (reduce (lambda (x ls)
            (cons (* x x) ls))
          empty
          L))

;; test
(sqr-list (list 1 2 3)) ;; => (list 1 4 9)
(sqr-list empty) ;; => empty


;;======
;; Q3
;;======
;; even-list : (listof number) -> (listof number)
;; generates the filtered given list of number that contains only/all even numbers
;; eg. (even-list (list 1 2 3 4 5 6)) => (list 2 4 6)
(define (even-list L)
  (reduce (lambda (x ls)
            (cond [(= (remainder x 2) 0) (cons x ls)]
                  [else ls]))
          empty
          L))

;; test
(even-list (list 1 2 3 4 5 6)) ;; => (list 2 4 6)
(even-list empty) ;; => empty


;;======
;; Q4
;;======
;; na :=
;;   name : string
;;   age  : number
(define-struct na (name age))

;; even-age-list : (listof na) -> (listof na)
;; generates the filtered given list of na that contains only/all na
;; whose age is even number
;; eg. (even-age-list (list (make-na "A" 20) (make-na "B" 19) (make-na "C" 22)))
;;     => (list (make-na "A" 20) (make-na "C" 22))
(define (even-age-list L)
  (reduce (lambda (x ls)
            (cond [(= (remainder (na-age x) 2) 0) (cons x ls)]
                  [else ls]))
          empty
          L))

;; test
(even-age-list (list (make-na "A" 20) (make-na "B" 19) (make-na "C" 22)))
;; => (list (make-na "A" 20) (make-na "C" 22))
(even-age-list empty) ;; => empty


;;======
;; Q5
;;======
;; project : (listof (listof X)) ((listof X) -> Y) -> (listof Y)
;; you can also say like this: (listof loX) (loX -> Y) -> (listof Y)
;; returns the list of Y : listof (f loX)
;; from the given list of loX, and the function that reduces loX to Y
;; eg. (project (list (list 1 2) (list 3 4))
;;              (lambda (alon) (reduce + 0 alon)))
;;     => (list 3 7)
(define (project L f)
  (reduce (lambda (loX ls)
            (cons (f loX) ls))
          empty
          L))

;; test 
(project (list (list 1 2) (list 3 4))
         (lambda (alon) (reduce + 0 alon))) ;; => (list 3 7)
