;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;****************************
;; Assignment 1 (2025/04/14)
;; 1TE24053S Shiota Sora
;;****************************


;;======
;; Q1
;;======
(define PI 3.14)
(* PI (* 5 5)) ;; => 78.5


;;======
;; Q2
;;======
(define a 1)
(define b -5)
(define c 6)
(/ (+ (* -1 b) (sqrt (- (* b b) (* 4 a c)))) (* 2 a)) ;; => 3


;;======
;; Q3
;;======
;; areaDisk : number -> number
;; computes the area of disk whose radius is given by `r`
;; eg. (areaDisk 2) => 12.56
(define (areaDisk r)
  (* PI (* r r)))
(areaDisk 2) ;; => 12.56


;;======
;; Q4
;;======
;; areaRing : number number -> number
;; computes the area of ring whose outer radius is `outer`
;; and inner radius is `inner`
;; eg. (areaRing 3 2) => 15.7
(define (areaRing outer inner)
  (- (areaDisk outer) (areaDisk inner)))
(areaRing 3 2) ;; => 15.7


;;======
;; Q5
;;======
(define y/d 149.64) ;; @ 2025/04/02
;; d2y : number -> number
;; converts dollar to yen
;; eg. (d2y 3) => 448.92
(define (d2y d)
  (* d y/d))
(d2y 3) ;; => 448.92


;;======
;; Q6
;;======
(define d/e 1.0802) ;; @ 2025/04/02
;; e2d : number -> number
;; converts euro to dollar
;; eg. (e2d 3) => 3.2406
(define (e2d e)
  (* e d/e))
(e2d 3) ;; => 3.2406


;;======
;; Q7
;;======
(define e/p 1.1966) ;; @2025/04/02
;; p2e : number -> number
;; converts pound to euro
;; eg. (p2e 3) => 3.5898
(define (p2e p)
  (* p e/p))
(p2e 3) ;; => 3.5898


;;======
;; Q8
;;======
;; p2y : number -> number
;; converts pound to yen
;; eg. (p2y 3) => 580.2593212944
(define (p2y p)
  (d2y (e2d (p2e p))))
(p2y 3) ;; => 580.2593212944


;;======
;; Q9
;;======
;; c2f : number -> number
;; converts Celcius to Fahrenheit
;; rel: f = 1.8 c + 32
;; eg. (c2f 36.6) ;; => 97.88
(define (c2f c)
  (+ (* 1.8 c) 32))
(c2f 36.6) ;; => 97.88
