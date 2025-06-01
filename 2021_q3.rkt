;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2021_q3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q3


;; (1)

(define (select-even ls)
  (cond [(empty? ls) empty]
        [(= (remainder (first ls) 2) 0) (cons (first ls) (select-even (rest ls)))]
        [else (select-even (rest ls))]))
(define L (list 28 30 31 33 35))
(select-even L) ;; => (list 28 30)


;; (2)

(define (filter1 relop ls t)
  (cond
    [(empty? ls) empty]
    [(relop (first ls) t) (cons (first ls) (filter1 relop (rest ls) t))]
    [else (filter1 relop (rest ls) t)]))
(define (select-even-f ls)
  (filter1 (lambda (x y) (= (remainder x y) 0)) ls 2))
(select-even-f L) ;; => (list 28 30)


;; (3)

(define (c2f c)
  (+ (* (/ 9 5) c) 32))
(c2f 30) ;; => 86


;; (4)
(define (map2 f ls)
  (cond
    [(empty? ls) empty]
    [else (cons (f (first ls)) (map2 f (rest ls)))]))
(define (convertCF loC)
  (map2 c2f loC))
(convertCF L) ;; => (list 82.4 86 87.8 91.4 95)