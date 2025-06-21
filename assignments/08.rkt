;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-8) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;****************************
;; Assignment 8 (2025/05/09)
;; 1TE24053S Shiota Sora
;;****************************


;;======
;; Q1
;;======
;; C2F : number -> number
;; converts a number in Celsius to the number in Fahrenheit
(define (C2F C)
  (+ (* C 1.8) 32))

;; convertCF : (listof number) -> (listof number)
;; converts the list of numbers in Celsius
;; to the list of numbers in Fahrenheit
;; eg. (convertCF (list -41.2 36.6 41.1))
;;     => (list -42.16 97.88 105.98)
(define (convertCF loC)
  (cond
    [(empty? loC) empty]
    [else (cons (C2F (first loC)) (convertCF (rest loC)))]))
;; test
(convertCF (list -41.2 36.6 41.1))
;; => (list -42.16 97.88 105.98)


;;======
;; Q2
;;======
;; I2C : number -> number
;; converts a number in inches to the number in centimeters
(define (I2C I)
  (/ I 2.54))

;; convertIC : (listof number) -> (listof number)
;; converts the list of numbers in inches
;; to the list of numbers in centimeters
;; eg. (convertIC (list 818 566 1182))
;;     => (list 322.047... 222.834... 465.354...)
(define (convertIC loI)
  (cond
    [(empty? loI) empty]
    [else (cons (I2C (first loI)) (convertIC (rest loI)))]))
;; test
(convertIC (list 818 566 1182))
;; => (list 322.047... 222.834... 465.354...)


;;======
;; Q3
;;======
;; map2 : (listof T) (T -> U) -> (listof U)
;; maps the list of T to the list of U
(define (map2 loT fn)
  (cond
    [(empty? loT) empty]
    [else (cons (fn (first loT)) (map2 (rest loT) fn))]))

;; convertCF2 : (listof number) -> (listof number)
;; converts the list of numbers in Celsius
;; to the list of numbers in Fahrenheit
;; using `map2` defined above
;; eg. (convertCF2 (list -41.2 36.6 41.1))
;;     => (list -42.16 97.88 105.98)
(define (convertCF2 loC)
  (map2 loC C2F))
;; test
(convertCF2 (list -41.2 36.6 41.1))
;; => (list -42.16 97.88 105.98)

;; convertIC2 : (listof number) -> (listof number)
;; converts the list of numbers in inches
;; to the list of numbers in centimeters
;; using `map2` defined above
;; eg. (convertIC (list 818 566 1182))
;;     => (list 322.047... 222.834... 465.354...)
(define (convertIC2 loI)
  (map2 loI I2C))
;; test
(convertIC (list 818 566 1182))
;; => (list 322.047... 222.834... 465.354...)


;;======
;; Q4
;;======
;; AddressNote :=
;;   name    : string
;;   age     : number
;;   address : string
(define-struct AddressNote (name age address))

;; livein? : AddressNote string -> bool
;; judges if the address of AN mathces given string
(define (livein? anAN place)
  (string=? (AddressNote-address anAN) place))


;;======
;; Q5
;;======
;; filter1 : T (U T -> bool) (listof U) -> (listof U)
;; selects u which satisfies `(op u t)` from the list
(define (filter1 t op alon)
  (cond
    [(empty? alon) empty]
    [(op (first alon) t) (cons (first alon) (filter1 t op (rest alon)))]
    [else (filter1 t op (rest alon))]))

;; ITO-people : (listof AddressNote) -> (listof AddressNote)
;; selects AN whose address is "ITO"
;; eg. (ITO-people (list
;;                  (make-AddressNote "a" 20 "ITO")
;;                  (make-AddressNote "b" 19 "TENJIN")))
;;     => (list (make-AddressNote "a" 20 "ITO"))

(define (ITO-people aloAN)
  (filter1 "ITO" livein? aloAN))
;; test
(ITO-people (list
             (make-AddressNote "a" 20 "ITO")
             (make-AddressNote "b" 19 "TENJIN")))
;; => (list (make-AddressNote "a" 20 "ITO"))


;;======
;; Q6
;;======
;; make-n-regular-polygon-w-features : posn number number number (posn -> #true) -> #true
;; draws n- `col` regular polygon with some features
;; function `feat` must take 1 argument: the position of each vertex
;; and must return #true
(define (make-n-regular-polygon-w-features c r i n col feat)
  (cond
    [(>= i n) true]
    [else
     (local (
             (define (calc-theta i)
               (* i (/ (* 2 pi) n)))
             (define (calc-posn i)
               (make-posn
                (+ (posn-x c) (* r (sin (calc-theta (+ i 1)))))
                (+ (posn-y c) (* r (cos (calc-theta (+ i 1))))))))
       (and
        (draw-solid-line (calc-posn i) (calc-posn (+ i 1)) col)
        (feat (calc-posn i))
        (sleep-for-a-while .3) 
        (make-n-regular-polygon-w-features c r (+ i 1) n col feat)))]))

;; make-n-regular-polygon-w-centerline : posn number number number -> #true
;; draws n- blue regular polygon with red centerlines
(define (make-n-regular-polygon-w-centerline c r i n)
  (local ((define (draw-centerline v) (draw-solid-line c v 'red)))
    (make-n-regular-polygon-w-features c r i n 'blue draw-centerline)))
;; test
(start 500 500)
(make-n-regular-polygon-w-centerline (make-posn 250 250) 100 0 30)
(sleep-for-a-while 5)
(stop)


;;======
;; Q7
;;======
;; make-n-regular-polygon-w-n-circles : posn number number number -> #true
;; draws n- blue regular polygon with red circles for each vertexes
(define (make-n-regular-polygon-w-n-circles c r i n)
  (local ((define (draw-v-circle v) (draw-circle v r 'red)))
    (make-n-regular-polygon-w-features c r i n 'blue draw-v-circle)))
;; test
(start 500 500)
(make-n-regular-polygon-w-n-circles (make-posn 250 250) 100 0 30)
(sleep-for-a-while 5)
(stop)

;; make-n-regular-polygon-w-nrp : posn number number number -> #true
;; draws n- blue regular polygon with m- red regular poygon for each vertexes
;; main n- polygon will be drawn using c R i n,
;; while m- polygon will be drawn using - r - m
(define (make-n-regular-polygon-w-nrp c R i n r m)
  (local (
          (define (empty-func v) true)
          (define (draw-mrp v) (make-n-regular-polygon-w-features v r 0 m 'red empty-func)))
    (make-n-regular-polygon-w-features c R i n 'blue draw-mrp)))
;; test
(start 500 500)
(make-n-regular-polygon-w-nrp (make-posn 250 250) 100 0 10 50 5)
(sleep-for-a-while 5)
(stop)
