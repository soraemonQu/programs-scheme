;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2025_q1) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q1


;; (1)

(define (str-len s)
  (string-length s))

(define (call s)
  (str-len s)) ;; <- カッコで二重に囲んではいけない

(call "hello")


;; (2)

(define (goal? s)
  (= s 100))

(define (message s)
  (cond
    [(goal? s) "Perfect!"] ;; <- boolどうしの比較は=でできない
    [else "Try harder."]))

(message 100)


;; (3)

(define-struct addr (city zip))

(define-struct prof (name addr))

(define (get-zip a-prof)
  (addr-zip (prof-addr a-prof)))

(define prof1
  (make-prof "Smith" (make-addr "Tokyo" "100-0001"))) ;; <- addr構造体は(make-addr)で定義する, stringは""で囲む

(get-zip prof1)


;; (4)

(define (overX? L X)
  (cond
    [(empty? L) false]
    [else (cond
            [(>= (first L) X) true]
            [else (overX? (rest L) X)])])) ;; <- overX?は引数Xが必要
(overX? (list 19 20 21 22) 20)
(overX? (list 10 15 18) 20)


;; (5)

(define PI 3.14)
(define (areaDisk r)
  (* r r PI))

(define (areaRing out in)
  (- (areaDisk out) (areaDisk in))) ;; <- areaDiskは(~)で囲まなければならない

(areaDisk 1)
(areaRing 5 3)
