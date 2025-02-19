;; Merge two sorted lists
(defun merge-lists (list1 list2)
  (cond 
    ((null list1) list2)
    ((null list2) list1)
    ((<= (car list1) (car list2))
     (cons (car list1) 
           (merge-lists (cdr list1) list2)))
    (t 
     (cons (car list2) 
           (merge-lists list1 (cdr list2))))))

;; Create sorted pairs from initial list
(defun make-sorted-pairs (L)
  (cond
    ;; Base cases
    ((null L) nil)  ; Empty list
    ((null (cdr L)) (list (list (car L))))  ; Single element
    ;; Take two elements and sort them
    (t (let ((pair (list (car L) (cadr L))))
         (cons (if (<= (car L) (cadr L))
                   pair
                   (reverse pair))
               (make-sorted-pairs (cddr L)))))))

;; Merge pairs of adjacent sorted lists
(defun merge-pass (sorted-lists)
  (cond
    ;; Base cases
    ((null sorted-lists) nil)
    ((null (cdr sorted-lists)) sorted-lists)
    ;; Merge adjacent pairs
    (t (cons (merge-lists (car sorted-lists)
                         (cadr sorted-lists))
             (merge-pass (cddr sorted-lists))))))

;; Main bottom-up mergesort function
(defun bottom-up-mergesort (L)
  (cond
    ;; Base cases
    ((null L) nil)
    ((null (cdr L)) L)
    ;; Main process
    (t (let ((sorted-pairs (make-sorted-pairs L)))
         (bottom-up-merge sorted-pairs)))))

;; Helper function to continue merging until we have one sorted list
(defun bottom-up-merge (lists)
  (if (null (cdr lists))  ; Only one list left?
      (car lists)         ; Return the sorted list
      (bottom-up-merge (merge-pass lists))))  ; Continue merging

;; Test cases

(make-sorted-pairs '(1 7 2 1 8 6 5 3 7 9 4))

(bottom-up-mergesort '(1 7 2 1 8 6 5 3 7 9 4))

(bottom-up-mergesort '())

(bottom-up-mergesort '(1))

(bottom-up-mergesort '(8 2 7 1 3 6 4 5))
