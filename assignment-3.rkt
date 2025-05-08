;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;****************************
;; Assignment 3 (2025/04/14)
;; 1TE24053S Shiota Sora
;;****************************


;;======
;; Q1
;;======

;; * supporting func *
;; is-divided-by? : number -> boolean
;; computes if the the number given by `dividend` is divided by the number given by `divisor` or not
(define (is-divided-by? dividend divisor)
  (= (remainder dividend divisor) 0))

;; * main func *
;; is-leap? : number → boolean (true, false)
;; to judge whether or not a given year (year) is a leap year, consider the following rules:
;; if ‘year’ can be divided by 400, it is a leap year
;; else if ‘year’ can be divided by 4 and cannot be by 100, it is also a leap year. (e.g. 1900 is not a leap year)
;; otherwise, ‘year’ is not a leap year.
(define (is-leap? year)
  (or
   (is-divided-by? year 400)
   (and
    (is-divided-by? year 4)
    (not (is-divided-by? year 100)))))

;;test
(is-leap? 2025) ;; => #false
(is-leap? 2028) ;; => #true


;;======
;; Q2
;;======

;; * supporting func *
;; is-short? : number -> boolean
;; computes if the month is a short month (Feb, Apr, Jun, Sep, Nov) or not
(define (is-short? month)
  (cond
    [(is-divided-by? month 2) (<= month 7)]
    [else (> month 7)]))

;; * main func *
;; num-of-days : number  number -> number
;; to compute the number of days for a year and a month given
(define (num-of-days year month)
  (cond
    [(and (is-leap? year) (= month 2)) 29]
    [(= month 2) 28]
    [(is-short? month) 30]
    [else 31]))

;; test
(num-of-days 2025 4) ;; => 30
(num-of-days 2025 5) ;; => 31
(num-of-days 2025 2) ;; => 28
(num-of-days 2024 2) ;; => 29


;;======
;; Q3
;;======

;; * supporting func *
;; zeller-fm : number number(3 ~ 14) number -> number(0 ~ 6)
;; computes the day of week of a date given by its "revised" year, day, and month,
;; using following zeller formula (for Gregorian calendar)
;; note: each day will be returned like this:
;;   0 as Sun, 1 as Mon, 2 as Tue, 3 as Wed, 4 as Thu, 5 as Fri, 6 as Sat
;; fm. [(Y + [Y / 4] + [Y / 400] - [Y / 100] + [(13 * M + 8) / 5] + D) mod 7],
;;       where  Y := y    , M := m     , D := d  (m >= 3)
;;              Y := y - 1, M := m + 12, D := d  (m = 1, 2)
;; eg. (zeller-fm 2024 14 4) => 2
;;     (zeller-fm 2025 4 14) => 1
(define (zeller-fm Y M D)
  (floor
   (remainder
    (+
     Y
     (quotient Y 4)
     (quotient Y 400)
     (* (quotient Y 100) -1)
     (quotient (+ (* 13 M) 8) 5)
     D)
    7)))
;; test
(zeller-fm 2024 14 4) ;; => 2
(zeller-fm 2025 4 14) ;; => 1

;; * main func *
;; zeller : number number(1 ~ 12) number -> number(0 ~ 6)
;; computes the day of week of a date given by its year, day, and month,
;; using `zeller-fm` function defined above
;; note: each day will be returned like this:
;;   0 as Sun, 1 as Mon, 2 as Tue, 3 as Wed, 4 as Thu, 5 as Fri, 6 as Sat
;; eg. (zeller 2005 2 4) => 2
;;     (zeller 2004 4 14) => 1
(define (zeller y m d)
  (cond
    [(<= m 2) (zeller-fm (- y 1) (+ m 12) d)]
    [else (zeller-fm y m d)]))

;;test
(zeller 2025 2 4) ;; => 2
(zeller 2025 4 14) ;; => 1


