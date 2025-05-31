;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2023_r_q4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; 1
(define (inv i)
  (cond [(= i 0) 0]
        [else (/ 1 i)]))

;; 2
(define (series n aterm)
  (cond
    [(= n 0) (aterm n)]
    [else (+ (aterm n) (series (- n 1) aterm))]))
(define (harmonic-series n)
  (series n inv))
(harmonic-series 100)
;; => 5.1873775176396202608051176...
(harmonic-series 1000)
;; => 7.4854708605503449126565182...

;; 3
(define (lieb-term i)
  (cond [(= (remainder i 2) 0) 0]
        [(= (remainder i 4) 1) (* 4 (inv i))]
        [else (* -4 (inv i))]))

;; 4
(define (leibniz n)
  (series n lieb-term))
(leibniz 100)
;; => 3.1215946525910104785131829...
(leibniz 1000)
;; => 3.1395926555897832385846406...

;; 5
(define (trapezoid2 n)
  (local ((define (f x) (sqrt (- 1 (* x x))))
          (define h (/ 2 n))
          (define (term i)
            (* h (+ (f (+ -1 (* h i))) (f (+ -1 (* h (+ i 1))))))))
    (series (- n 1) term)))
(trapezoid2 100)
;; => #i3.1382685110984982
(trapezoid2 1000)
;; => #i3.14148747700214
