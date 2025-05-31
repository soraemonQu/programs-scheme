;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2023_r_q1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; 1
(define (a2r ang)
  (* pi ang (/ 1 180)))
(a2r 30)

;; 2
(define (triangle r th)
  (* r r (sin (a2r th))))
(triangle 10 30)
;; => #i49.99999999999999

;; 3
(define (lineLength r th)
  (sqrt (* 2 r r (- 1 (cos (a2r th))))))
(lineLength 10 30)
;; => #i5.176380902050414

;; 4
(define (arcLength r th)
  (* r (a2r (- 180 th))))
(arcLength 10 30)
;; => #i26.179938779914945

;; 5
(define (sectorArea r th)
  (* (/ 1 2) r r (a2r (- 180 th))))
(sectorArea 10 30)
;; => #i130.89969389957471
