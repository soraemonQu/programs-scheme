;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2023_r_q2) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (mult? m n)
  (= (remainder m n) 0))

;; 1
(define (leapYear y)
  (cond [(not (and (mult? y 100) (not (mult? y 400)))) 0]
        [(mult? y 4) 1]
        [else 0]))
(leapYear 2023)

;; 2
(define-struct date (y m d))
(define (ndom adate)
  (cond [(and (= (leapYear (date-y adate)) 1) (= (date-m adate) 2)) 29]
        [(= (date-m adate) 2) 28]
        [(or (= (date-m adate) 4) (= (date-m adate) 6) (= (date-m adate) 9) (= (date-m adate) 11)) 30]
        [else 31]))
(ndom (make-date 2023 6 3))

;; 3
(define (nord adate)
  (- (ndom adate) (date-d adate)))
(nord (make-date 2023 6 30))
(nord (make-date 2023 6 3))

;; 4
(define (downname i)
  (cond [(= i 0) 'Sunday]
        [(= i 1) 'Monday]
        [(= i 2) 'Tuesday]
        [(= i 3) 'Wednesday]
        [(= i 4) 'Thursday]
        [(= i 5) 'Friday]
        [(= i 6) 'Saturday]))

;; 5
(define (dow adate)
  (local ((define (zeller y m d)
            (floor (remainder (+ y
                                 (floor (/ y 4))
                                 (floor (/ y 400))
                                 (- (floor (/ y 100)))
                                 (floor (/ (+ (* 13 m) 8) 5))
                                 d) 7)))
          (define (conv adate)
            (cond [(<= (date-m adate) 2) (make-date (- (date-y adate) 1) (+ (date-m adate) 12) (date-d adate))]
                  [else adate]))
          (define bdate (conv adate)))
    (downname (zeller (date-y bdate) (date-m bdate) (date-d bdate)))))
(dow (make-date 2025 5 31))
