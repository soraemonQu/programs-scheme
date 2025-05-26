;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2024_q1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; ^2 : number -> number
;; computes the squared value of given value
(define (^2 v)
  (expt v 2))
;; ^/2 : number -> number
;; computes the square root of given value
(define (^/2 v)
  (expt v 0.5))

;;======
;; Q1
;;======

;; cos-theta : number number number -> number
;; computes the cosA by given a, b, c (Triangle side lengths)
;; fm. cos(theta) = (b^2 + c^2 - a^2) / 2 b c
;; eg. (cos-theta 7 5 8) => 0.5
(define (cos-theta a b c)
  (/ (+ (^2 b) (^2 c) (- (^2 a))) (* 2 b c)))

;; test
(cos-theta 7 5 8)
;; => 0.5

;; answer
(cos-theta 3 7 5)
;; 0.9285714


;;======
;; Q2
;;======

;; cos-to-sin : number ->number
;; converts the cosA to sinA
;; fm. sinA = root(1 - (cosA)^2)
;; eg. (cos-to-sin 0.5) => 0.866025...
(define (cos-to-sin cos-t)
  (^/2 (- 1 (^2 cos-t))))

;; test
(cos-to-sin 0.5)
;; => #i0.8660254037844386

;; answer
(cos-to-sin (cos-theta 3 7 5))
;; => #i0.3711537444790451


;;======
;; Q3
;;======

;; triangle-area : number number number -> number
;; computes the area of a triangle given by its side length: a, b, c
;; fm. S = b c sinA / 2
;; eg. (triangle-area 3 5 4) => 6
(define (triangle-area a b c)
  (/ (* b c (cos-to-sin (cos-theta a b c))) 2))

;; test
(triangle-area 3 5 4)
;; => 6

;; answer
(triangle-area 3 7 5)
;; => #i6.495190528383289


;;======
;; Q4
;;======

;; triangle-area-heron : number number number -> number
;; computes the area of a triangle given by its side length: a, b, c
;; fm. S = root(s (s - a) (s - b) (s - c))
;; eg. (triangle-area-heron 3 5 4) => 6
(define (triangle-area-heron a b c)
  (local ((define (s- x)
            (- (/ (+ a b c) 2) x)))
    (^/2 (* (s- 0) (s- a) (s- b) (s- c)))))

;; test
(triangle-area-heron 3 5 4)
;; => 6

;; answer
(triangle-area-heron 3 7 5)
;; => #i6.49519052838329


;;======
;; Q5
;;======

;; inradius : number number number -> number
;; computes the radius of the inscribed circle of given triangle
;; fm. r = S / s
;; eg. (inradius 3 5 4) => 1
(define (inradius a b c)
  (/ (triangle-area a b c) (/ (+ a b c) 2)))

;; test
(inradius 3 5 4)
;; => 1

;; answer
(inradius 3 7 5)
;; => #i0.8660254037844386

