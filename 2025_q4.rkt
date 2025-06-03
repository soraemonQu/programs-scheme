;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2025_q4) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Q4

(define-struct grade (name math english science))
(define student-grades
  (list
   (make-grade "Alice" 90 85 88)
   (make-grade "Bob" 75 80 78)
   (make-grade "Charlie" 92 92 95)
   (make-grade "Diana" 68 72 72)
   (make-grade "Eve" 88 94 90)))


;; (1)

(define (best-subject a-grade)
  (cond
    [(and (>= (grade-math a-grade) (grade-english a-grade))
          (>= (grade-math a-grade) (grade-science a-grade))) "Math"]
    [(>= (grade-english a-grade) (grade-science a-grade)) "English"]
    [else "Science"]))
(best-subject (make-grade "Alice" 90 85 88)) ;; => "Math"


;; (2)

(define (name-and-best-subjects grades)
  (cond
    [(empty? grades) empty]
    [else (cons (list (grade-name (first grades)) (best-subject (first grades))) (name-and-best-subjects (rest grades)))]))
(name-and-best-subjects student-grades) 
;; => (shared ((-9- "English"))
;;      (list
;;       (list "Alice" "Math")
;;       (list "Bob" -9-)
;;       (list "Charlie" "Science")
;;       (list "Diana" -9-)
;;       (list "Eve" -9-)))


;; (3)


;; (number number -> number) -> (grade grade -> grade)
(define (math- op)
  (lambda (x y) (op (grade-math x) (grade-math y))))

(define (filter1 relop L t)
  (cond
    [(empty? L) empty]
    [(relop
      (first L) t)
     (cons (first L) (filter1 relop (rest L) t))]
    [else (filter1 relop (rest L) t)]))


(define (sort-by-math alog)
  (cond
    [(empty? alog) empty]
    [else
     (append
      (sort-by-math (filter1 (math- >) alog (first alog)))
      (filter1 (math- =) alog (first alog))
      (sort-by-math (filter1 (math- <) alog (first alog))))]))

(sort-by-math student-grades)
;; => (list
;;     (make-grade "Charlie" 92 92 95)
;;     (make-grade "Alice" 90 85 88)
;;     (make-grade "Eve" 88 94 90)
;;     (make-grade "Bob" 75 80 78)
;;     (make-grade "Diana" 68 72 72))


;; (4)

(define (sort-by pick alog)
  (local ((define (picked- relop)
            (lambda (x y) (relop (pick x) (pick y)))))
    (cond
      [(empty? alog) empty]
      [else
       (append
        (sort-by-math (filter1 (picked- >) alog (first alog)))
        (filter1 (picked- =) alog (first alog))
        (sort-by-math (filter1 (picked- <) alog (first alog))))])))

(define (sort-by-math2 grades)
  (sort-by grade-math grades))
(define (sort-by-english2 grades)
  (sort-by grade-english grades))
(define (sort-by-science2 grades)
  (sort-by grade-science grades))

(sort-by-math2 student-grades)
;; => (list
;;     (make-grade "Charlie" 92 92 95)
;;     (make-grade "Alice" 90 85 88)
;;     (make-grade "Eve" 88 94 90)
;;     (make-grade "Bob" 75 80 78)
;;     (make-grade "Diana" 68 72 72))

(sort-by-english2 student-grades)
;; => (list
;;     (make-grade "Charlie" 92 92 95)
;;     (make-grade "Eve" 88 94 90)
;;     (make-grade "Alice" 90 85 88)
;;     (make-grade "Bob" 75 80 78)
;;     (make-grade "Diana" 68 72 72))
(sort-by-science2 student-grades)
;; => (list
;;     (make-grade "Charlie" 92 92 95)
;;     (make-grade "Eve" 88 94 90)
;;     (make-grade "Alice" 90 85 88)
;;     (make-grade "Bob" 75 80 78)
;;     (make-grade "Diana" 68 72 72))
