;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2024_q5) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;======
;; Q1
;;======
(define (hanoi n from to aux)
  (cond
    [(= n 0) empty]
    [else
     (append
      (hanoi (- n 1) from aux to)
      (list (list from to))
      (hanoi (- n 1) aux to from))]))
(hanoi 3 'A 'B 'C)


;;======
;; Q2
;;======
(define (hanoi-accum n from to aux)
  (local ((define (hanoi-inner n from to aux accum)
            (cond
              [(= n 0) accum]
              [else
               (hanoi-inner (- n 1) from aux to (append (list (list from to))
                                                        (hanoi-inner (- n 1) aux to from empty)
                                                        accum))])))
    (hanoi-inner n from to aux empty)))
(hanoi-accum 3 'A 'B 'C)


;;======
;; Q3
;;======
(define (reverse-list L)
  (cond [(empty? L) empty]
        [else (append (reverse-list (rest L)) (list (first L)))]))
(reverse-list (list 'A 'B 'C 'D 'E))


;;======
;; Q4
;;======
(define (reverse-moves L)
  (cond [(empty? L) empty]
        [else (append (reverse-moves (rest L)) (list (reverse-list (first L))))]))
(reverse-moves (list (list 'A 'C) (list 'A 'B) (list 'C 'B)))
