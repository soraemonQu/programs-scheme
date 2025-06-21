;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2021_q4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q4


;; (1)

(define (naturals n)
  (cond [(>= n 1) (cons n (naturals (- n 1)))]
        [else empty]))
(naturals 100) ;; => (list 100 ... 1)


;; (2)

(define (naturals-i2n i n)
  (cond [(<= i n) (cons i (naturals-i2n (+ i 1) n))]
        [else empty]))
(naturals-i2n 2 5) ;; => (list 2 3 4 5)


;; (3)

(define (naturals2 n)
  (naturals-i2n 1 n))
(naturals2 100) ;; => (list 1 ... 100)


;; (4)

(define (rel2abs ls)
  (local ((define (inner _ls cur)
            (cond [(empty? _ls) empty]
                  [else (cons (+ (first _ls) cur) (inner (rest _ls) (+ (first _ls) cur)))])))
    (inner ls 0)))
(rel2abs (list 7 10 3 5)) ;; => (list 7 17 20 25)
