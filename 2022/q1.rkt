;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2022_q1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q1


;; (1)

(define (calc-tri l)
  (* l l (/ 1 4)))
(define (calc-hcirc l)
  (* pi l l (/ 1 16)))
(define (calc-area l)
  (- (calc-tri l) (calc-hcirc l)))
(calc-area 10)
;; => #i5.365045915063792


;; (2) - 1

(define (birthday? y m d)
  (and (= y 1999) (= m 9) (= d 15))
  )

(define (question y m d)
  (cond
    [(birthday? y m d) "Happy"] ;; "=" must compare numbers, not boolean
    [else "Sad..."]))

(question 1999 9 15)



;; (2) - 2

(define-struct DEMO (name sex))

(define-struct BIR (y m d))

(define-struct BODY (h w))

(define-struct HUM (DEMO BIR BODY))

(define (get-bir a-person)
  (HUM-BIR a-person))

(define a-person
  (make-HUM (make-DEMO "dai" "male") (make-BIR 1900 1 1) (make-BODY 190 90))) ;; HUM must be costructed by 3 args, not 5
(get-bir a-person)


;; (3)

(define-struct INGREDIENTS (Currency Price ExRate))

(define (cost ls)
  (cond [(empty? ls) 0]
        [else (+ (* (INGREDIENTS-Price (first ls)) (INGREDIENTS-ExRate (first ls))) (cost (rest ls)))]))
