;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-5) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;****************************
;; Assignment 5 (2025/04/21)
;; 1TE24053S Shiota Sora
;;****************************


;;======
;; Q1
;;======
(define L (list 1 2 3))


;;======
;; Q2
;;======
(first L)


;;======
;; Q3
;;======
(first (rest L))


;;======
;; Q4
;;======
(first (rest (rest L)))


;;======
;; Q5
;;======
(define L2 empty)
;;(first L2)
;; => first: expects a non-empty list; given: '()


;;======
;; Q6
;;======
(define L3 (list 1 2 3 4))
(first (rest (rest (rest L3))))


;;======
;; Q7
;;======
(cons 0 L)


;;======
;; Q8
;;======
(cons (first L) (cons 1 (rest L)))


;;======
;; Q9
;;======
(cons (first L) (cons (first (rest L)) (cons 2 (rest (rest L)))))


;;======
;; Q10
;;======
(rest L)


;;======
;; Q11
;;======
;; add-to-tail : lon number -> lon
;; add given number to the last of list
;; eg. (add-to-tail empty 0) => (list 0)
;;     (add-to-tail (list 1 2 3) 4) => (list 1 2 3 4)
(define (add-to-tail L n)
  (cond
    [(empty? L) (list n)]
    [else (cons (first L) (add-to-tail (rest L) n))]))
;; test
(add-to-tail empty 0) ;; => (list 0)
(add-to-tail (list 1 2 3) 4) ;; => (list 1 2 3 4)


;;======
;; Q12
;;======
;; last-number : lon -> number
;; returns the last number of the given list,
;; while returns `'error` for the empty list
;; eg. (last-number (list 1 2 3)) => 3
;;     (last-number empty) => 'error
(define (last-number L)
  (cond
    [(empty? L) 'error]
    [(empty? (rest L)) (first L)]
    [else (last-number (rest L))]))
;; test
(last-number (list 1 2 3))
(last-number empty)


;;======
;; Q13
;;======
(define-struct ball (posn speed r c))
(define-struct speed (dx dy))
(define a-ball (make-ball (make-posn 250 250) (make-speed 10 10) 5 'blue))
;; next-position: posn speed -> posn
(define (next-position a-posn a-speed)
  (make-posn (+ (posn-x a-posn) (speed-dx a-speed))
             (+ (posn-y a-posn) (speed-dy a-speed))))
;; get-next-ball: ball -> ball
(define (get-next-ball a-ball)
  (make-ball (next-position (ball-posn a-ball) (ball-speed a-ball))
             (ball-speed a-ball)
             (ball-r a-ball)
             (ball-c a-ball)))
;; draw-ball : ball -> true
(define (draw-ball a-ball)
  (draw-solid-disk (ball-posn a-ball) (ball-r a-ball) (ball-c a-ball)))
;; draw-n-balls : ball number -> true
(define (draw-n-balls a-ball n)
  (cond
    [(= n 0) (draw-ball a-ball)]
    [else
     (and
      (draw-ball a-ball)
      (draw-n-balls (get-next-ball a-ball) (- n 1)))]))
(start 500 500)
(draw-n-balls a-ball 5)
(sleep-for-a-while 5)
(stop)
