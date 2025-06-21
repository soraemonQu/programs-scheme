;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2022_q3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q3


;; (1)
(define (fibonacci n)
  (/ (- (expt (/ (+ 1 (sqrt 5)) 2) n) (expt (/ (- 1 (sqrt 5)) 2) n)) (sqrt 5)))
(fibonacci 1)
;; => #i1.0
(fibonacci 10)
;; => #i54.99999999999999


;; (2)
(define (fibonacci2 n)
  (cond [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fibonacci2 (- n 1)) (fibonacci2 (- n 2)))]))
(fibonacci2 1)
;; => 1
(fibonacci2 10)
;; => 55


;; (3)
(define (fibonacci_seq n)
  (cond [(>= n 1) (cons (fibonacci2 n) (fibonacci_seq (- n 1)))]
        [else empty]))
(fibonacci_seq 10)
;; => (list 55 34 21 13 8 5 3 2 1 1)


;; (4)
(define (seq n f)
  (cond [(>= n 1) (cons (f n) (seq (- n 1) f))]
        [else empty]))
(seq 10 fibonacci2)
;; => (list 55 34 21 13 8 5 3 2 1 1)


;; (5)
(define (series n f)
  (cond [(>= n 0) (+ (f n) (series (- n 1) f))]
        [else 0]))
(series 10 fibonacci2)
;; => 143

(define (fibonacci_sum n)
  (- (fibonacci2 (+ n 2)) (fibonacci2 1)))
(fibonacci_sum 10)
;; => 143 - ok
