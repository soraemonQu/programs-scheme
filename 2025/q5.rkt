;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2025_q5) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q5


;; (1)

(define-struct state (blue yellow))

(define (make-boat-list n)
  (local ((define (inner i j)
            (cond
              [(> i n) empty]
              [(> (+ i j) n) (inner (+ i 1) 0)]
              [else (cons (make-state i j) (inner i (+ j 1)))])))
    (inner 0 0)))
(make-boat-list 2)
;; => (list
;;     (make-state 0 0)
;;     (make-state 0 1)
;;     (make-state 0 2)
;;     (make-state 1 0)
;;     (make-state 1 1)
;;     (make-state 2 0))


;; (2)

(define-struct situation (X Y xy))
(define SS (make-situation (make-state 3 3) (make-state 0 0) #true))

(define (make-next-situation as boat)
  (cond
    [(situation-xy as) (make-situation
                        (make-state
                         (- (state-blue (situation-X as)) (state-blue boat))
                         (- (state-yellow (situation-X as)) (state-yellow boat)))
                        (make-state
                         (+ (state-blue (situation-Y as)) (state-blue boat))
                         (+ (state-yellow (situation-Y as)) (state-yellow boat)))
                        #false)]
    [else (make-situation
                        (make-state
                         (+ (state-blue (situation-X as)) (state-blue boat))
                         (+ (state-yellow (situation-X as)) (state-yellow boat)))
                        (make-state
                         (- (state-blue (situation-Y as)) (state-blue boat))
                         (- (state-yellow (situation-Y as)) (state-yellow boat)))
                        #true)]))

(make-next-situation SS (make-state 1 1))
(make-next-situation SS (make-state 0 2))
;; (make-situation (make-state 2 2) (make-state 1 1) #false)
;; (make-situation (make-state 3 1) (make-state 0 2) #false)


;; (3)




;; (4)




;; (5)


