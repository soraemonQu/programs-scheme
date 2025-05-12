;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname assignment-13) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;*****************************
;; Assignment 13 (2025/06/01)
;; 1TE24053S Shiota Sora
;;*****************************


;; node :=
;;   value : number
;;   left  : listof node
;;   right : listof node
;;   | empty
(define-struct node (value left right))


;;======
;; Q1
;;======
;; total-tree-value : node -> number
;; calculates the total value of a tree
(define (total-tree-value a-tree)
  (cond
    [(empty? a-tree) 0]
    [else (+ (total-tree-value (node-left a-tree))
             (node-value a-tree)
             (total-tree-value (node-right a-tree)))]))

;; test
(total-tree-value (make-node 63 empty empty))
;; => 63
(total-tree-value (make-node 63
                             (make-node 29
                                        empty
                                        (make-node 89
                                                   empty
                                                   empty))
                             empty))
;; => 181

;;======
;; Q2
;;======
;; total-tree-value-2 : node -> number
;; calculates the total value of a tree using accumlator style
(define (total-tree-value-2 a-tree)
  (local ((define (total-tree-value-accum a-tree accum)
            (cond
              [(empty? a-tree) accum]
              ;; => (left + (right + (value)))
              [else (total-tree-value-accum (node-left a-tree)
                                            (total-tree-value-accum (node-right a-tree)
                                                                    (+ accum (node-value a-tree))))])))
    (total-tree-value-accum a-tree 0)))

;; test
(total-tree-value-2 (make-node 63 empty empty))
;; => 63
(total-tree-value-2 (make-node 63
                               (make-node 29
                                          empty
                                          (make-node 89
                                                     empty
                                                     empty))
                               empty))
;; => 181


;;======
;; Q3
;;======
;; max-branch-value : node -> number
;; computes the max value in a tree using accumlator style
(define (max-branch-value a-tree)
  (local ((define (max-branch-value-accum a-tree accum)
            (cond
              [(empty? a-tree) accum]
              ;; => max(left + value, right + value)
              [else (max (max-branch-value-accum (node-left a-tree)
                                                 (+ accum (node-value a-tree)))
                         (max-branch-value-accum (node-right a-tree)
                                                 (+ accum (node-value a-tree))))])))
    (max-branch-value-accum a-tree 0)))

;; test
(max-branch-value (make-node 63 empty empty))
;; => 63
(max-branch-value (make-node 63
                               (make-node 29
                                          (make-node 16
                                                     empty
                                                     empty)
                                          (make-node 89
                                                     empty
                                                     empty))
                               (make-node 51
                                          empty
                                          empty)))
;; => 181
