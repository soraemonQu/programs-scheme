;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;****************************
;; Assignment 2 (2025/04/14)
;; 1TE24053S Shiota Sora
;;****************************


;;======
;; Q1
;;======

;; 1.
;; attendees : number -> number
;; estimates the number of attendees using given ticket price
;; when price is $5, the number of attendees will be 120
;; the number will increase by 15 for each $0.1 discount
;; ie. attendees = 120 + (15 / 0.1) * (5 - ticketPrice)
;; eg. (attendees 5.0) => 120
;;     (attendees 4.8) => 150
(define (attendees ticketPrice)
  (+ 120 (* (/ 15 0.1) (- 5 ticketPrice))))
;; test
(attendees 5.0) ;; => 120
(attendees 4.8) ;; => 150

;; 2.
;; cost :: number -> number
;; estimates the total cost (including fixed cost $10 and cost per person $0.5),
;; using given ticketPrice
;; ie. cost = 10 + attendees * 0.5
;; eg. (cost 5.0) => 10 + 120 * 0.5 => 70
;;     (cost 4.8) => 10 + 150 * 0.5 => 85
(define (cost ticketPrice)
  (+ 10 (* (attendees ticketPrice) 0.5)))
;; test
(cost 5.0) ;; => 70
(cost 4.8) ;; => 85

;; 3.
;; revenue :: number -> number
;; estimates the revenue (product of attendees and ticketPrice),
;; using given ticketPrice
;; ie. revenue = attendees * ticketPrice
;; eg. (revenue 5.0) => 120 * 5.0 => 600
;;     (revenue 4.8) => 150 * 4.8 => 720
(define (revenue ticketPrice)
  (* (attendees ticketPrice) ticketPrice))
;; test
(revenue 5.0) ;; => 600
(revenue 4.8) ;; => 720

;; 4.
;; profit :: number -> number
;; estimates the profit using given ticketPrice
;; ie. profit = revenue - cost
;; eg. (profit 5.0) => 700 - 70 => 530
;;     (profit 4.8) => 720 - 85 => 635
(define (profit ticketPrice)
  (- (revenue ticketPrice) (cost ticketPrice)))
;; test
(profit 5.0) ;; => 530
(profit 4.8) ;; => 635


;;== what we want to know ==
(profit 5) ;; => 530


;;======
;; Q2
;;======

;; constants (convertion ratio)
(define cm/inch 2.54)
(define inches/foot 12)
(define feet/yard 3)
(define yards/rod 5.5)
(define rods/furlong 40)
(define furlongs/mile 8)

;; xxx->yyy implies the convertion from xxx to yyy
;; definitions
(define (inch->cm inch)
  (* inch cm/inch))
(define (feet->inches feet)
  (* feet inches/foot))
(define (yards->feet yards)
  (* yards feet/yard))
(define (rods->yards rods)
  (* rods yards/rod))
(define (furlongs->rods furlongs)
  (* furlongs rods/furlong))
(define (miles->furlongs miles)
  (* miles furlongs/mile))

;; reuseing it
(define (feet->cm feet)
  (inch->cm (feet->inches feet)))
(define (yards->cm yards)
  (feet->cm (yards->feet yards)))
(define (rods->inches rods)
  (feet->inches (yards->feet (rods->yards rods))))
(define (miles->feet miles)
  (yards->feet (rods->yards (furlongs->rods (miles->furlongs miles)))))

;; test
(inch->cm 2) ;; => 5.08
(feet->inches 2) ;; => 24
(yards->feet 2) ;; => 6
(rods->yards 2) ;; => 11
(furlongs->rods 2) ;; => 80
(miles->furlongs 2) ;; => 16
(feet->cm 2) ;; => 60.96
(yards->cm 2) ;; => 182.88
(rods->inches 2) ;; => 396
(miles->feet 2) ;; => 10560
