;; 1. Partition function
;; Takes a list and returns two nearly equal halves
(defun partition (L)
  (partition-helper L nil nil))

;; Helper function that maintains two lists for processed items
(defun partition-helper (unprocessed left right)
  (cond 
    ;; Base case: no more items to process
    ((null unprocessed) 
     (cons left right))
    ;; Only one item left - add to left list
    ((null (cdr unprocessed)) 
     (cons (cons (car unprocessed) left) right))
    ;; Take two items: first to left, second to right
    (t (partition-helper 
        (cddr unprocessed)           ; Skip first two items
        (cons (car unprocessed) left) ; Add first to left
        (cons (cadr unprocessed) right))))) ; Add second to right

;; 2. Merge function to combine two sorted lists
(defun merge-lists (list1 list2)
  (cond 
    ;; Base cases: if either list is empty, return the other
    ((null list1) list2)
    ((null list2) list1)
    ;; Compare first elements and recursively merge
    ((<= (car list1) (car list2))
     (cons (car list1) 
           (merge-lists (cdr list1) list2)))
    (t 
     (cons (car list2) 
           (merge-lists list1 (cdr list2))))))

;; 3. Main mergesort function
(defun mergesort (L)
  (cond 
    ;; Base cases: empty list or single element
    ((null L) nil)
    ((null (cdr L)) L)
    ;; Recursive case:
    (t (let* ((split (partition L))
              (left (car split))
              (right (cdr split)))
         ;; 1. Partition list
         ;; 2. Sort each half recursively
         ;; 3. Merge the sorted halves
         (merge-lists (mergesort left)
                     (mergesort right))))))

;;Test cases
(mergesort '())

(mergesort '(1))

(mergesort '(1 2 3 4 5))

(mergesort '(5 4 3 2 1))

(mergesort '(8 2 7 1 3 6 4 5))
