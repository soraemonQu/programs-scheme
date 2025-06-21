;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2025_q2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q2

(define-struct point (x y))
(define p1 (make-point 10 20))
(define p2 (make-point 100 100))
(define p3 (make-point 95 95))


;; (1)

(define (move-point pt dx dy)
  (make-point (+ (point-x pt) dx) (+ (point-y pt) dy)))
(move-point p1 5 10) ;; => (make-point 15 30)


;; (2)

(define (in-bounds? pt)
  (and (>= (point-x pt) 0)
       (<= (point-x pt) 100)
       (>= (point-y pt) 0)
       (<= (point-y pt) 100)))
(in-bounds? p2) ;; => #true


;; (3)

(define (all-in-bounds lop)
  (cond
    [(empty? lop) empty]
    [else (cons (in-bounds? (first lop)) (all-in-bounds (rest lop)))]))
(all-in-bounds (list p1 p2 p3)) ;; => (list #true #true #true)


;; (4)

(define (filter-points pred lop)
  (cond
    [(empty? lop) empty]
    [else (cons (pred (first lop)) (filter-points pred (rest lop)))]))
(filter-points in-bounds? (list p1 p2 p3)) ;; => (list #true #true #true)


;; (5)

(define (filter-moved-points pred lop dx dy)
  (filter-points (lambda (pt) (pred (move-point pt dx dy))) lop))
(filter-moved-points in-bounds? (list p1 p2 p3) 10 10) ;; => (list #true #false #false)
