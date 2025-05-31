;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2023_r_q3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; 1
(define (between_low_high ls low high)
  (cond
    [(empty? ls) empty]
    [(and (>= (first ls) low) (<= (first ls) high)) (cons (first ls) (between_low_high (rest ls) low high))]
    [else (between_low_high (rest ls) low high)]))
(define L (list 1 2 3 4 5 6 7 8 9))
(between_low_high L 2 7)
;; => (list 2 3 4 5 6 7)

;; 2
(define (filter2 aloX lop pred1 pred2 t1 t2)
  (cond
    [(empty? aloX) empty]
    [(lop (pred1 (first aloX) t1) (pred2 (first aloX) t2)) (cons (first aloX) (filter2 (rest aloX) lop pred1 pred2 t1 t2))]
    [else (filter2 (rest aloX) lop pred1 pred2 t1 t2)]))
(define (between_low_high2 ls low high)
  (filter2 ls (lambda (x y) (and x y)) >= <= low high))
(between_low_high2 L 2 7)
;; => (list 2 3 4 5 6 7)

;; 3
(define-struct StudentScore (name class score))
(define (overT? anSS t)
  (>= (StudentScore-score anSS) t))
(overT? (make-StudentScore "hoge" "fuga" 18) 23)
(overT? (make-StudentScore "hoge" "fuga" 23) 23)

;; 4
(define (type? anSS type)
  (string=? (StudentScore-class anSS) type))
(type? (make-StudentScore "hoge" "fuga" 18) "hage")
(type? (make-StudentScore "hoge" "fuga" 18) "fuga")

;; 5
(define (classScore aloSS)
  (filter2 aloSS (lambda (x y) (and x y)) overT? type? 50 "A"))
(define aloSS (list (make-StudentScore "P1" "S" 100)
                    (make-StudentScore "P2" "S" 90)
                    (make-StudentScore "P3" "A" 80)
                    (make-StudentScore "P4" "A" 85)
                    (make-StudentScore "P5" "A" 49)
                    (make-StudentScore "P6" "B" 78)))
(classScore aloSS)
;; (shared ((-3- "A")) (list (make-StudentScore "P3" -3- 80) (make-StudentScore "P4" -3- 85)))
