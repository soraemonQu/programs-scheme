;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2022_q4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q4


;; (1)

(define (add2tail x lox)
  (cond [(empty? lox) (list x)]
        [else (cons (first lox) (add2tail x (rest lox)))]))
(add2tail 2 (list 0 1))
;; => (list 0 1 2)
(add2tail "c" (list "a" "b"))
;; => (list "a" "b" "c")


;; (2)

(define (naturals n)
  (local ((define (add2tail x lox)
            (cond [(empty? lox) (list x)]
                  [else (cons (first lox) (add2tail x (rest lox)))])))
    (cond [(>= n 1) (add2tail n (naturals (- n 1)))]
          [else empty])))
(naturals 10)
;; => (list 1 2 3 4 5 6 7 8 9 10)


;; (3)

(define (naturals-add80 n)
  (map (lambda (x) (+ x 80)) (naturals n)))
(naturals-add80 5)
;; => (list 81 82 83 84 85)


;; (4)

(define-struct np (n p))
(define (makeNP aloN aloP)
  (cond [(or (empty? aloN) (empty? aloP)) empty]
        [else (cons (make-np (first aloN) (first aloP)) (makeNP (rest aloN) (rest aloP)))]))
(makeNP (list "a" "b" "c") (list 80 75 90))
;; => (list (make-np "a" 80) (make-np "b" 75) (make-np "c" 90))


;; (5)

(define (nthP n aloNP)
  (cond [(= n 1) (np-p (first aloNP))]
        [else (nthP (- n 1) (rest aloNP))]))
(nthP 3 (list (make-np "a" 80) (make-np "b" 75) (make-np "c" 90)))
;; => 90
