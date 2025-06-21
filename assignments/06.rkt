;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-6) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;****************************
;; Assignment 6 (2025/04/29)
;; 1TE24053S Shiota Sora
;;****************************


;;======
;; Q1
;;======
(define a-posn (make-posn 3 4))

;; gets x of a-posn
(posn-x a-posn)
;; => 3


;;======
;; Q2
;;======
;; gets y of a-posn
(posn-y a-posn)
;; => 4


;;======
;; Q3
;;======
(define a-posn1 (make-posn 3 4))
(define a-posn2 (make-posn 5 6))

;; computes the distance between a-posn1 and a-posn2
(sqrt (+
       (expt (- (posn-x a-posn1) (posn-x a-posn2)) 2)
       (expt (- (posn-y a-posn1) (posn-y a-posn2)) 2)))
;; => #i2.8284271247461903


;;======
;; Q4
;;======
;; distance : posn posn -> number
;; computes the distance between given two points
(define (distance a-posn1 a-posn2)
  (sqrt (+
         (expt (- (posn-x a-posn1) (posn-x a-posn2)) 2)
         (expt (- (posn-y a-posn1) (posn-y a-posn2)) 2))))


;;======
;; Q5
;;======
;; AddressNote :=
;;   name    : string
;;   age     : number
;;   address : string
(define-struct AddressNote (name age address))

(define an-AN (make-AddressNote "Taro" 35 "Ito-Campus"))

;; gets the name of an-AN
(AddressNote-name an-AN)
;; => "Taro"


;;======
;; Q6
;;======
;; select-name : loAN string -> loAN
;; selects AddressNotes whose name match given string from list of AN
;; eg. (select-name (list
;;                   (make-AddressNote "Minami" 6 "Kasuga")
;;                   (make-AddressNote "Miyuka" 5 "Tsubomi")
;;                   (make-AddressNote "Tomoka" 4 "Souri")
;;                  "Miyuka")
;;     => (list (make-AddressNote "Miyuka" 5 "Tsubomi"))
(define (select-name alo-AN a-name)
  (cond
    [(empty? alo-AN) empty]
    [(string=? (AddressNote-name (first alo-AN)) a-name) (cons (first alo-AN) (select-name (rest alo-AN) a-name))]
    [else (select-name (rest alo-AN) a-name)]))
;; test
(select-name (list
              (make-AddressNote "Minami" 6 "Kasuga")
              (make-AddressNote "Miyuka" 5 "Tsubomi")
              (make-AddressNote "Tomoka" 4 "Souri"))
             "Miyuka")
;; => (list (make-AddressNote "Miyuka" 5 "Tsubomi"))
(select-name (list
              (make-AddressNote "Minami" 6 "Kasuga")
              (make-AddressNote "Miyuka" 5 "Tsubomi")
              (make-AddressNote "Tomoka" 4 "Souri"))
             "Katsuo")
;; => '()


;;======
;; Q7
;;======
;; sum-of-even : lon -> number
;; computes the sum of even numbers in the list
;; eg. (sum-of-even (list 88 75 22)) => 110
;;     (sum-of-even empty) => 0
(define (sum-of-even L)
  (cond
    [(empty? L) 0]
    [(even? (first L)) (+ (first L) (sum-of-even (rest L)))]
    [else (sum-of-even (rest L))]))
;; test
(sum-of-even (list 88 75 22)) ;; => 110
(sum-of-even empty) ;; => 0


;;======
;; Q8
;;======
;; odd-list : number -> lon
;; creates the list of positive even numbers
;; in decreasing oder, whose length is given
;; eg. (odd-list 3) => (list 5 3 1)
;;     (odd-list 4) => (list 7 5 3 1)
(define (odd-list n)
  (cond
    [(> n 0) (cons (- (* n 2) 1) (odd-list (- n 1)))]
    [else empty]))
;; test
(odd-list 3) ;; => (list 5 3 1)
(odd-list 4) ;; => (list 7 5 3 1)


;;======
;; Q9
;;======
;; supporting func
;; calc-theta : number number -> number
(define (calc-theta i n)
  (* i (/ (* 2 pi) n)))

;; supporting func
;; calc-posn : posn number number number -> posn
(define (calc-posn c r i n)
  (make-posn
   (+ (posn-x c) (* r (sin (calc-theta (+ i 1) n))))
   (+ (posn-y c) (* r (cos (calc-theta (+ i 1) n))))))

;; make-n-regular-polygon: posn number number number -> true 
;; c: a center of the n regular polygon,  
;; r: the distance between c and a vertex on a circle whose center and radius are c and r. 
;; i: the i-th order of the vertex 
;; n: the number of vertex of a regular-polygon 
(define (make-n-regular-polygon c r i n)
  (cond
    [(>= i n) true]
    [else
     (and
      (draw-solid-line (calc-posn c r i n) (calc-posn c r (+ i 1) n) 'blue)
      (make-n-regular-polygon c r (+ i 1) n))]))
(start 500 500)
(make-n-regular-polygon (make-posn 250 250) 100 0 3)
(sleep-for-a-while 5)
(stop)
