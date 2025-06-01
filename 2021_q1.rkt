;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2021_q1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q1

(define (mult? m n)
  (= (remainder m n) 0))


;; (1)

(define (leapYear? y)
  (and (mult? y 4) (not (and (mult? y 100) (not (mult? y 400))))))
(leapYear? 1990) ;; => #false
(leapYear? 2020) ;; => #true
(leapYear? 2021) ;; => #false


;; (2)

(define (getNumdays y m)
  (cond [(and (leapYear? y) (= m 2)) 29]
        [(= m 2) 28]
        [(or (= m 4) (= m 6) (= m 9) (= m 11)) 30]
        [else 31]))
(getNumdays 2020 2) ;; => 29
(getNumdays 2021 2) ;; => 28
(getNumdays 2021 5) ;; => 21
(getNumdays 2021 6) ;; => 30


;; (3)

(define (zellar-formula y m d)
  (remainder (+ y (floor (/ y 4)) (floor (/ y 400)) (- (floor (/ y 100))) (floor (/ (+ (* 13 m) 8) 5)) d) 7))
(zellar-formula 2021 6 7) ;; => 1
(zellar-formula 2021 2 1) ;; => 5


;; (4)
(define (zellar y m d)
  (cond [(or (= m 1) (= m 2)) (zellar-formula (- y 1) (+ m 12) d)]
        [else (zellar-formula y m d)]))
(zellar 2021 1 1) ;; => 1
(zellar 2021 2 1) ;; => 1
(zellar 2021 6 7) ;; => 2


;; (5)
(define (MonList y m)
  (local ((define (pick-mon d)
            (cond [(> d (getNumdays y m)) empty]
                  [(= (zellar y m d) 1) (cons d (pick-mon (+ d 1)))]
                  [else (pick-mon (+ d 1))])))
    (pick-mon 1)))
(MonList 2021 5) ;; => (list 3 10 17 24 31)
(MonList 2020 2) ;; => (list 3 10 17 24)

