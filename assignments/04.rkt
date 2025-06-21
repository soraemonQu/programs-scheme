;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;****************************
;; Assignment 4 (2025/04/21)
;; 1TE24053S Shiota Sora
;;****************************


;; ! note: we cannot read from your instruction about `get-next-ball`,
;; ! whether you meant after `1` unit time or after `ut` unit time,
;; ! but I decided to calculate `a-posn` after the next an unit time,
;; ! as the name `next` implies
;; ! if not correct, you had better obviously write it


;;======
;; Q1
;;======
;; speed (structure) :=
;;   dx : number
;;   dy : number
(define-struct speed (dx dy))


;;======
;; Q2
;;======
;; ball (structure) :=
;;   posn  : posn
;;   speed : speed
;;   r     : number
;;   c     : number
(define-struct ball (posn speed r c))


;;======
;; Q3
;;======
;; get-posn : ball -> posn
;; gets posn from ball
(define (get-posn a-ball)
  (ball-posn a-ball))


;;======
;; Q4
;;======
;; get-speed : ball -> speed
;; get speed frpm ball
(define (get-speed a-ball)
  (ball-speed a-ball))


;;======
;; Q5
;;======
;; get-dx : speed -> number
;; get dx from speed
(define (get-dx a-speed)
  (speed-dx a-speed))

;; get-dy : speed -> number
;; get dy from speed
(define (get-dy a-speed)
  (speed-dy a-speed))


;;======
;; Q6
;;======
;; get-new-posn :: posn speed number -> posn
;; calculate new a-posn after an unit time
(define (get-new-posn a-posn a-speed)
  (make-posn
    (+ (posn-x a-posn) (get-dx a-speed))
    (+ (posn-y a-posn) (get-dy a-speed))))

;; get-next-ball : ball number -> ball
;; calculate new a-ball after an unit time
(define (get-next-ball a-ball)
  (make-ball
   (get-new-posn (get-posn a-ball) (get-speed a-ball))
   (get-speed a-ball)
   (ball-r a-ball)
   (ball-c a-ball)))


;;======
;; Q7
;;======
;; get-next-ball-w-accel : ball number -> ball
;; calculates new a-ball with acceleration given by `a`,
;; after an unit time
(define (get-next-ball-w-accel a-ball a)
  (make-ball
   (get-new-posn (get-posn a-ball) (get-speed a-ball))
   (make-speed
    (+ (get-dx (get-speed a-ball)) a)
    (+ (get-dy (get-speed a-ball)) a))
   (ball-r a-ball)
   (ball-c a-ball)))


;;======
;; Q8
;;======
;; draws canvas whose size is 500 by 500
(start 500 500)


;;======
;; Q9
;;======
;; create a-ball with given data
(define a-ball
  (make-ball
   (make-posn 250 250)
   (make-speed 10 10)
   5
   'blue))


;;======
;; Q10
;;======
;; draw-ball : ball -> #true
;; draw given ball on the campus
(define (draw-ball a-ball)
  (draw-solid-disk (get-posn a-ball) (ball-r a-ball) (ball-c a-ball)))

;; draws a-ball defined above, on the canvas
(draw-ball a-ball)


;;======
;; Q11
;;======
;; draws a-ball after 0 unit time
(draw-ball a-ball)

;; draws a-ball after 1 unit time
(draw-ball (get-next-ball a-ball))

;; draws a-ball after 2 unit time
(draw-ball (get-next-ball (get-next-ball a-ball)))

;; draws a-ball after 3 unit time
(draw-ball (get-next-ball (get-next-ball (get-next-ball a-ball))))

;; draws a-ball after 4 unit time
(draw-ball (get-next-ball (get-next-ball (get-next-ball (get-next-ball a-ball)))))

;; draws a-ball after 5 unit time
(draw-ball (get-next-ball (get-next-ball (get-next-ball (get-next-ball (get-next-ball a-ball))))))


;;======
;; Q12
;;======
;; draws a-ball after 0 unit time
(draw-ball a-ball)

;; draws a-ball after 1 unit time
(draw-ball (get-next-ball-w-accel a-ball 10))

;; draws a-ball after 2 unit time
(draw-ball (get-next-ball-w-accel (get-next-ball-w-accel a-ball 10) 10))

;; draws a-ball after 3 unit time
(draw-ball (get-next-ball-w-accel (get-next-ball-w-accel (get-next-ball-w-accel a-ball 10) 10) 10))

;; draws a-ball after 4 unit time
(draw-ball (get-next-ball-w-accel (get-next-ball-w-accel (get-next-ball-w-accel (get-next-ball-w-accel a-ball 10) 10) 10) 10))

;; draws a-ball after 5 unit time
(draw-ball (get-next-ball-w-accel (get-next-ball-w-accel (get-next-ball-w-accel (get-next-ball-w-accel (get-next-ball-w-accel a-ball 10) 10) 10) 10) 10))


;;======
;; close canvas
(stop)


