;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2025_q3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q3


;; (1)

(define (an n)
  (/ n))
(an 5) ;; => 0.2


;; (2)

(define (generate-sequence f n)
  (local ((define (i2n i)
            (cond
              [(<= i n) (cons (f i) (i2n (+ i 1)))]
              [else empty])))
    (i2n 1)))
(generate-sequence an 5) ;; => (list 1 0.5 0.3 0.25 0.2)


;; (3)

(define (partial-sum f n)
  (cond
    [(>= n 1) (+ (f n) (partial-sum f (- n 1)))]
    [else 0]))
(partial-sum an 5) ;; => 2.283


;; (4)

(define (partial-sum-range f i m)
  (cond
    [(> i m) 0]
    [else (+ (f i) (partial-sum-range f (+ i 1) m))]))
(partial-sum-range an 3 5) ;; => 0.783
(partial-sum-range an 7 5) ;; => 0


;; (5)
(define (filtered-partial-sum-range f i m valid?)
  (cond
    [(> i m) 0]
    [(valid? (f i)) (+ (f i) (filtered-partial-sum-range f (+ i 1) m valid?))]
    [else (filtered-partial-sum-range f (+ i 1) m valid?)]))

(define (valid? val)
  (<= val 0.25))

(filtered-partial-sum-range an 3 5 valid?) ;; => 0.45
(filtered-partial-sum-range an 7 5 valid?) ;; => 0

