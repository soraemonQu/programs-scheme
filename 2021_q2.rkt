;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2021_q2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q2

;; (1)

(define L (list 34 87 (list 23 (list 7 (list 54 74))) "23" (list 31 5 8) "98" 100))
;; (a)
(first (rest L))
;; (b)
(first (rest (rest (rest L))))
;; (c)
(first (first (rest (first (rest (first (rest (rest L))))))))


;; (2)

(define (list-included? ls)
  (cond [(empty? ls) #false]
        [else (or (list? (first ls)) (list-included? (rest ls)))]))
(list-included? L) ;; => #true
(list-included? (list 3 4 (list 5))) ;; => #true


;; (3)

(define (select-not-List ls)
  (cond [(empty? ls) empty]
        [(list? (first ls)) (select-not-List (rest ls))]
        [else (cons (first ls) (select-not-List (rest ls)))]))
(select-not-List L) ;; => (list 34 87 "23" "98" 100)
(select-not-List (list 1 3 "5" (list 7))) ;; => (list 1 3 "5")


;; (4)

(define (sum ls)
  (cond [(empty? ls) 0]
        [(number? (first ls)) (+ (first ls) (sum (rest ls)))]
        [else (sum (rest ls))]))
(sum (select-not-List L)) ;; => 221
(sum (list 23 54 "98" 7)) ;; => 84


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
(recur_sum L) ;; => 423
