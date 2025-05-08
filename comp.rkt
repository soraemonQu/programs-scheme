;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname comp) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;======
;; Q1
;;======
;; comp :=
;;   real : number
;;   imag : number
(define-struct comp (real imag))

;; C1 := 1 + i
(define C1 (make-comp 1 1))
;; C2 := 3 + 4i
(define C2 (make-comp 3 4))


;;======
;; Q2
;;======
;; comp+ : comp comp -> comp
(define (comp+ a b)
  (make-comp
   (+ (comp-real a) (comp-real b))
   (+ (comp-imag a) (comp-imag b))))
;; comp- : comp comp -> comp
(define (comp- a b)
  (make-comp
   (- (comp-real a) (comp-real b))
   (- (comp-imag a) (comp-imag b))))
;; comp* : comp comp -> comp
(define (comp* a b)
  (make-comp
   (- (* (comp-real a) (comp-real b)) (* (comp-imag a) (comp-imag b)))
   (+ (* (comp-imag a) (comp-real b)) (* (comp-real a) (comp-imag b)))))
;; comp/ : comp comp -> comp
(define (comp/ a b)
  (make-comp
   (/
    (+ (* (comp-real a) (comp-real b)) (* (comp-imag a) (comp-imag b)))
    (+ (* (comp-real b) (comp-real b)) (* (comp-imag b) (comp-imag b))))
   (/
    (- (* (comp-imag a) (comp-real b)) (* (comp-real a) (comp-imag b)))
    (+ (* (comp-real b) (comp-real b)) (* (comp-imag b) (comp-imag b))))))

;; C1 + C2
(comp+ C1 C2) ;; => (make-comp 4 5)
;; C1 - C2
(comp- C1 C2) ;; => (make-comp -2 -3)
;; C1 * C2
(comp* C1 C2) ;; => (make-comp -1 7)
;; C1 / C2
(comp/ C1 C2) ;; => (make-comp 0.28 -0.04)


;;======
;; Q3
;;======
;; Polar :=
;;   magnitude : number
;;   angle     : number
(define-struct Polar (magnitude angle))

;; comp-to-polar : comp -> Polar
(define (comp-to-polar a-comp)
  (make-Polar (sqrt (+ (expt (comp-real a-comp) 2)
                       (expt (comp-imag a-comp) 2)))
              (atan (/ (comp-imag a-comp) (comp-real a-comp)))))

;; C1
(comp-to-polar C1)
;; => (make-Polar #i1.4142135623730951 #i0.7853981633974483)
;; C2
(comp-to-polar C2)
;; => (make-Polar 5 #i0.9272952180016122)


;;======
;; Q4
;;======
;; polar-comp* : Polar Polar -> Polar
(define (polar-comp* a b)
  (make-Polar (* (Polar-magnitude a) (Polar-magnitude b))
              (+ (Polar-angle a) (Polar-angle b))))
;; C1 * C1
(polar-comp* (comp-to-polar C1) (comp-to-polar C1))
;; => (make-Polar #i2.0000000000000004 #i1.5707963267948966)
;; C1 * C2
(polar-comp* (comp-to-polar C1) (comp-to-polar C2))
;; => (make-Polar #i7.0710678118654755 #i1.7126933813990606)
(comp-to-polar (comp* C1 C2))
;; => (make-Polar #i7.0710678118654755 #i-1.4288992721907328)