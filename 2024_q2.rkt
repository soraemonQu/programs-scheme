;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2024_q2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
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

;; comp :=
;;   real : number
;;   imag : number
(define-struct comp (real imag))


;; define C1
(define C1 (make-comp 1 1))
(define C2 (make-comp 3 4))

;; Utils

;; r- : comp -> number
;; gets the real-part
(define (r- cm)
  (comp-real cm))

;; i- : comp -> number
;; gets the imag-part
(define (i- cm)
  (comp-imag cm))

;; r^2- : comp -> number
;; eg. (r^2- (make-comp a b)) => (+ (* a a) (* b b))
(define (r^2- cm)
  (+ (^2 (r- cm)) (^2 (i- cm))))

;; ang- : comp -> number
;; eg. (ang- (make-comp (cos t) (sin t))) => t
(define (ang- comp)
  (cond [(< (r- comp) 0) (+ (atan (/ (i- comp) (r- comp))) pi)]
        [(< (i- comp) 0) (+ (atan (/ (i- comp) (r- comp))) (* 2 pi))]
        [else (atan (/ (i- comp) (r- comp)))]))


;;======
;; Q2
;;======

;; (1)

;; comp+ : comp comp -> comp
(define (comp+ a b)
  (make-comp (+ (r- a) (r- b)) (+ (i- a) (i- b))))
;; answer
(comp+ C1 C2) ;; => (make-comp 4 5)


;; (2)

;; comp- : comp comp -> comp
(define (comp- a b)
  (make-comp (- (r- a) (r- b)) (- (i- a) (i- b))))
;; answer
(comp- C1 C2) ;; => (make-comp -2 -3)


;; (3)

;; comp* : comp comp -> comp
(define (comp* a b)
  (make-comp (- (* (r- a) (r- b)) (* (i- a) (i- b)))
             (+ (* (i- a) (r- b)) (* (r- a) (i- b)))))
;; answer
(comp* C1 C2) ;; => (make-comp -1 7)


;; (4)

;; comp/ : comp comp -> comp
(define (comp/ a b)
  (make-comp (/ (+ (* (r- a) (r- b)) (* (i- a) (i- b))) (r^2- b))
             (/ (- (* (i- a) (r- b)) (* (r- a) (i- b))) (r^2- b))))
;; answer
(comp/ C1 C2) ;; => (make-comp 0.28 -0.04)


;;======
;; Q3
;;======

;; Polar :=
;;   magnitude : number
;;   angle     : number
(define-struct Polar (magnitude angle))

;; comp-to-polar : comp -> Polar
;; eg. (comp-to-Polar C1) => (make-Polar 1.4142... 0.7853...)
(define (comp-to-Polar comp)
  (make-Polar (^/2 (r^2- comp)) (ang- comp)))
;; answer
(comp-to-Polar C1)
;; => (make-Polar #i1.4142135623730951 #i0.7853981633974483)


;; Utils

;; m- : Polar -> number
;; gets the magnitude of given Polar
(define (m- pol)
  (Polar-magnitude pol))

;; a- : Polar -> number
;; gets the angle of given Polar
(define (a- pol)
  (Polar-angle pol))


;;======
;; Q4
;;======

;; Polar-comp* : Polar Polar -> Polar
(define (Polar-comp* a b)
  (make-Polar (* (m- a) (m- b)) (+ (a- a) (a- b))))
;; answer
(Polar-comp* (comp-to-Polar C1) (comp-to-Polar C2))
;; => (make-Polar #i7.0710678118654755 #i1.7126933813990606)
(comp-to-Polar (comp* C1 C2))
;; => (make-Polar #i7.0710678118654755 #i1.7126933813990604)
