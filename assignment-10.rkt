;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-10) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;****************************
;; Assignment 9 (2025/05/19)
;; 1TE24053S Shiota Sora
;;****************************


;;======
;; Q1
;;======
;; series : number (number -> number) -> number
;; computes the sum of `(aterm k)`, k moving 0 to n
(define (series n aterm)
  (cond
    [(= n 0) (aterm n)]
    [else (+ (aterm n) (series (- n 1) aterm))]))

;; trapezoid : (number -> number) number number number -> number
(define (trapezoid f a b n)
  (local ((define h (/ (- b a) n))
          (define (fx_ i)
            (f (+ a (* i h))))
          (define (term i)
            (* (/ h 2)
               (+ (fx_ i)
                  (fx_ (+ i 1))))))
    (series (- n 1) term)))
;; test
(trapezoid sin 0 pi 10000) ;; => #i1.9999999835506606


;;======
;; Q2
;;======
;; integral : (number -> number) number number number -> number
(define (integral f a b n)
  (local ((define h (/ (- b a) (* 2 n)))
          (define (fx_ i)
            (f (+ a (* i h))))
          (define (term i)
            (* (/ h 3)
               (+ (fx_ (* 2 i))
                  (* 4 (fx_ (+ (* 2 i) 1)))
                  (fx_ (+ (* 2 i) 2))))))
    (series (- n 1) term)))
;; test
(integral sin 0 pi 10000) ;; => #i1.9999999999999991


;;======
;; Q3
;;======
;; integral-s3/8 : (number -> number) number number number -> number
(define (integral-s3/8 f a b n)
  (local ((define h (/ (- b a) (* 3 n)))
          (define (fx_ i)
            (f (+ a (* i h))))
          (define (term i)
            (* (/ (* 3 h) 8)
               (+ (fx_ (* 3 i))
                  (* 3 (fx_ (+ (* 3 i) 1)))
                  (* 3 (fx_ (+ (* 3 i) 2)))
                  (fx_ (+ (* 3 i) 3))))))
    (series (- n 1) term)))
;; test
(integral-s3/8 sin 0 pi 10000)
