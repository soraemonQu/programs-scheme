;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-11) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;*****************************
;; Assignment 11 (2025/05/26)
;; 1TE24053S Shiota Sora
;;*****************************


;;======
;; Q1
;;======
;; AddressNote :=
;;   name    : string
;;   age     : number
;;   address : string
(define-struct AddressNote (name age address))

;; op-age : (numbae -> number) -> (AddressNote -> AddressNote)
;; returns the operator function between two AddressNote,
;; based on their `age` field
;; eg. ((op-age >) a-AN b-AN) => (> (AddressNote-age a-AN) (AddressNote-age b-AN))
(define (op-age op)
  (lambda (a-AN b-AN) (op (AddressNote-age a-AN) (AddressNote-age b-AN))))

;; smaller : (listof AddressNote) AddressNote -> listof AddressNote
;; returns filtered given list of AN whose age is lower than that of anAN
(define (smaller aloAN anAN)
  (filter1 (op-age <)
           aloAN
           anAN))

;; larger : (listof AddressNote) AddressNote -> listof AddressNote
;; returns filtered given list of AN whose age is higher than that of anAN
(define (larger aloAN anAN)
  (filter1 (op-age >)
           aloAN
           anAN))

;; equivalent : (listof AddressNote) AddressNote -> listof AddressNote
;; returns filtered given list of AN whose age is equal to that of anAN
(define (equivalent aloAN anAN)
  (filter1 (op-age =)
           aloAN
           anAN))

;; quick-sort : (listof X) -> (listof X)
;; * here, AddressNote will be inserted to `X` *
(define (quick-sort aloX)
  (cond
    [(empty? aloX) empty]
    [else
     (append
      (quick-sort (smaller aloX (first aloX)))
      (equivalent aloX (first aloX))
      (quick-sort (larger aloX (first aloX))))]))

;; filter1 : (X T -> boolean) (listof X) T -> listof X
(define (filter1 op aloX t)
  (cond
    [(empty? aloX) empty]
    [(op (first aloX) t) (cons (first aloX) (filter1 op (rest aloX) t))]
    [else (filter1 op (rest aloX) t)]))


;; test
(quick-sort (list
             (make-AddressNote "Taro" 18 "Hakata")
             (make-AddressNote "Rin" 19 "Tojinmachi")
             (make-AddressNote "Hanako" 21 "Meinohama")
             (make-AddressNote "Yuji" 19 "Susenji")
             (make-AddressNote "Ichiro" 18 "Gakkentoshi")))
;;  =>
;; (list
;;  (make-AddressNote "Taro" 18 "Hakata")
;;  (make-AddressNote "Ichiro" 18 "Gakkentoshi")
;;  (make-AddressNote "Rin" 19 "Tojinmachi")
;;  (make-AddressNote "Yuji" 19 "Susenji")
;;  (make-AddressNote "Hanako" 21 "Meinohama"))
