;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2024_q4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;======
;; Q1
;;======
(define-struct line (p1 p2))
(define A (make-posn 30 50))
(define B (make-posn 70 180))
(define C (make-posn 123 150))
(define D (make-posn 273 135))
(define aloposn (list A B C D))
(define (pickup-two-posn-in-order L)
  (cond [(empty? (rest L)) empty]
        [else (cons (make-line (first L) (first (rest L))) (pickup-two-posn-in-order (rest L)))]))
(pickup-two-posn-in-order aloposn)


;;======
;; Q2
;;======
(define (pickup-and-make-circle L)
  (local ((define head (first L))
          (define (pickup-and-make-circle-sub L) 
            (cond
              [(empty? L) empty]
              [(empty? (rest L)) (list (make-line (first L) head))]
              [else (cons (make-line (first L) (first (rest L))) (pickup-two-posn-in-order (rest L)))])))
            (pickup-and-make-circle-sub L)))
(pickup-and-make-circle aloposn)


;;======
;; Q3
;;======
(define (reduce op base L)
  (cond
    [(empty? L) base]
    [else (op (first L) (reduce op base (rest L)))]))

(define (sum-lines L)
  (reduce (lambda (fs rs)
                  (+ (posn-x (line-p1 fs))
                     (posn-y (line-p1 fs))
                     (posn-x (line-p2 fs))
                     (posn-y (line-p2 fs))
                     rs)) 0 L))
(sum-lines  (list (make-line (make-posn 30 50) (make-posn 70 180))
                  (make-line (make-posn 70 180) (make-posn 123 150))
                  (make-line (make-posn 123 150) (make-posn 30 50))))
;; => 1206
