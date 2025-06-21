;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2022_q2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q2


;; (1)
(define L (list 34 87 "13" (list 23 (list 7 (list 54 74))) "23" (list 31 5 8) "98" 100))
;; (a)
(first (rest (rest L)))
;; (b)
(first (first (rest (rest (rest L)))))
;; (c)
(first (first (rest (first (rest (first (rest (rest (rest L)))))))))


;; (2)
(define (how-many-subList ls)
  (cond [(empty? ls) 0]
        [(list? (first ls)) (+ 1 (how-many-subList (rest ls)))]
        [else (how-many-subList (rest ls))]))
(how-many-subList L)
;; => 2


;; (3)
(define (how-many-subList2 ls)
  (cond [(empty? ls) 0]
        [(list? (first ls)) (+ 1 (how-many-subList2 (first ls)) (how-many-subList2 (rest ls)))]
        [else (how-many-subList2 (rest ls))]))
(how-many-subList2 L)
;; => 4


;; (4)
(define (sum ls)
  (cond [(empty? ls) 0]
        [(number? (first ls)) (+ (first ls) (sum (rest ls)))]
        [else (sum (rest ls))]))
(sum (list 23 54 "98" 7))
;; => 84


;; (5)
(define (reduce op base ls)
  (cond
    [(empty? ls) base]
    [else (op (first ls) (reduce op base (rest ls)))]))
(define (recur_sum ls)
  (reduce (lambda (x y)
                  (cond [(list? x) (+ (recur_sum x) y)]
                        [(number? x) (+ x y)]
                        [else y])) 0 ls))
(recur_sum L)
;; => 423
