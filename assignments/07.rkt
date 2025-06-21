;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-7) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;****************************
;; Assignment 7 (2025/05/09)
;; 1TE24053S Shiota Sora
;;****************************


;;======
;; Q1
;;======
;; over90? : (listof number) -> bool
;; judges if the list contains number 90 or more
;; eg. (over90? empty) => #false
;;     (over90? (list 56)) => #false
;;     (over90? (list 56 90)) => #true
;;     (over90? (list 18 56 92)) => #true
(define (over90? alon)
  (cond
    [(empty? alon) false]
    [else (or (>= (first alon) 90) (over90? (rest alon)))]))
;; test
(over90? empty) ;; => #false
(over90? (list 56)) ;; => #false
(over90? (list 56 90)) ;; => #true
(over90? (list 18 56 92)) ;; => #true


;;======
;; Q2
;;======
;; over70? : (listof number) -> bool
;; judges if the list contains number 70 or more
;; eg. (over70? empty) => #false
;;     (over70? (list 56)) => #false
;;     (over70? (list 56 70)) => #true
;;     (over70? (list 18 56 72)) => #true
(define (over70? alon)
  (cond
    [(empty? alon) false]
    [else (or (>= (first alon) 70) (over70? (rest alon)))]))
;; test
(over70? empty) ;; => #false
(over70? (list 56)) ;; => #false
(over70? (list 56 70)) ;; => #true
(over70? (list 18 56 72)) ;; => #true


;;======
;; Q3
;;======
;; overX? : (listof number) number -> bool
;; judges if the list contains number X or more
;; eg. (overX? empty 60) => #false
;;     (overX? (list 56) 60) => #false
;;     (overX? (list 56 60) 60) => #true
;;     (overX? (list 18 56 62) 60) => #true
(define (overX? alon X)
  (cond
    [(empty? alon) false]
    [else (or (>= (first alon) X) (overX? (rest alon) X))]))
;; test
(overX? empty 60) ;; => #false
(overX? (list 56) 60) ;; => #false
(overX? (list 56 60) 60) ;; => #true
(overX? (list 18 56 62) 60) ;; => #true


;;======
;; Q4
;;======
;; below : (listof number) number -> (listof number)
;; selects numbers less than given t from the list
;; eg. (below (list 18 56 62) 60) => (list 18 56)
(define (below alon t)
  (cond
    [(empty? alon) empty]
    [(< (first alon) t) (cons (first alon) (below (rest alon) t))]
    [else (below (rest alon) t)]))
;; test
(below (list 18 56 62) 60) ;; => (list 18 56)


;;======
;; Q5
;;======
;; above : (listof number) number -> (listof number)
;; selects numbers more than given t from the list
;; eg. (above (list 18 56 62) 60) => (list 62)
(define (above alon t)
  (cond
    [(empty? alon) empty]
    [(> (first alon) t) (cons (first alon) (above (rest alon) t))]
    [else (above (rest alon) t)]))
;; test
(above (list 18 56 62) 60) ;; => (list 62)


;;======
;; Q6
;;======
;; filter1 : T (U T -> bool) (listof U) -> (listof U)
;; selects U which satisfies `(op U t)` from the list
(define (filter1 t op alon)
  (cond
    [(empty? alon) empty]
    [(op (first alon) t) (cons (first alon) (filter1 t op (rest alon)))]
    [else (filter1 t op (rest alon))]))


;;======
;; Q7
;;======
;; AddressNote :=
;;   name    : string
;;   age     : number
;;   address : string
(define-struct AddressNote (name age address))

;; overT? : AddressNote number -> bool
;; judges if the age of AN is t or more
(define (overT? anAN t)
  (>= (AddressNote-age anAN) t))


;;======
;; Q8
;;======
;; adult-list : (listof AddressNote) -> (listof AddressNote)
;; selects AN whose age is 20 or more from the given list of AN
;; eg. (adult-list (list
;;                  (make-AddressNote "a" 20 "ITO")
;;                  (make-AddressNote "b" 19 "TENJIN")))
;;     => (list (make-AddressNote "a" 20 "ITO"))
(define (adult-list aloAN)
  (filter1 20 overT? aloAN))

;; test
(adult-list (list
             (make-AddressNote "a" 20 "ITO")
             (make-AddressNote "b" 19 "TENJIN")))
;; => (list (make-AddressNote "a" 20 "ITO"))
