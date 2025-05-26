;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2024_q3) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct poi (n c posn))
(define ki (make-poi "kyushu" "ito" (make-posn 33.597714884595 130.224178697653))) 
(define os (make-poi "osaka" "suita" (make-posn 34.818907008236 135.5239087976828))) 
(define ky (make-poi "kyoto" "yoshida" (make-posn 35.0271515681175 135.7814527266046))) 
(define nh (make-poi "nagoya" "higashiyama" (make-posn 35.15603783630271 136.9642665014021))) 
(define th (make-poi "tokyo" "hongo" (make-posn 35.7139980075925 139.7627586553776))) 
(define ta (make-poi "tohoku" "aobayama" (make-posn 38.255527560398 140.8339938865095))) 
(define hs (make-poi "hokkaido" "sapporo" (make-posn 43.0786627909189 141.3400988306920))) 
(define alopoi (list ki os ky nh th ta hs))

;;======
;; Q1
;;======
(define (nth n L)
  (cond
    [(empty? L) 'error]
    [(= n 1) (first L)]
    [else (nth (- n 1) (rest L))]))


;;======
;; Q2
;;======
(define (round4_posn a-posn)
  (local ((define (round4 val)
            (/ (round (* val 1000)) 1000)))
    (make-posn (round4 (posn-x a-posn)) (round4 (posn-y a-posn)))))


;;======
;; Q3
;;======
(define (trans_posn L)
  (cond
    [(empty? L) empty]
    [else (cons (make-poi (poi-n (first L)) (poi-c (first L)) (round4_posn (poi-posn (first L)))) (trans_posn (rest L)))]))
;; answer
(trans_posn alopoi)


;;======
;; Q4
;;======
(define (between_low_high_x? low high a-posn)
  (and (>= (posn-x a-posn) low) (<= (posn-x a-posn) high)))
(define (between_low_high_y? low high a-posn)
  (and (>= (posn-y a-posn) low) (<= (posn-y a-posn) high)))
(define (between_low_high? low high val)
  (and (>= val low) (<= val high)))
(define (new_between_low_high_x? low high a-posn)
  (between_low_high? low high (posn-x a-posn)))
(define (new_between_low_high_y? low high a-posn)
  (between_low_high? low high (posn-y a-posn)))

;;======
;; Q5
;;======
(define (get_lh_poi x-low x-high y-low y-high L)
  (cond
    [(empty? L) empty]
    [(and (between_low_high_x? x-low x-high (poi-posn (first L)))
          (between_low_high_y? y-low y-high (poi-posn (first L))))
     (cons (first L) (get_lh_poi x-low x-high y-low y-high (rest L)))]
    [else (get_lh_poi x-low x-high y-low y-high (rest L))]))
;; answer
(get_lh_poi 33 34 130 136 (list ki os ky))
;; => (list (make-poi "kyushu" "ito" (make-posn 33.597714884595 130.224178697653)))