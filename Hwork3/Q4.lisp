;; Insert a single element into a sorted list
(defun insert-into-sorted (element sorted-list)
  (cond 
    ;; Base case 1: Empty list - return list with just the element
    ((null sorted-list) 
     (list element))
    
    ;; Base case 2: Element is smaller than first item
    ;; Put it at the beginning
    ((<= element (car sorted-list)) 
     (cons element sorted-list))
    
    ;; Recursive case: Element goes somewhere after first item
    ;; Keep first item and recursively insert into rest of list
    (t (cons (car sorted-list) 
            (insert-into-sorted element (cdr sorted-list))))))

;; Main insertion sort function
(defun insertion-sort (list)
  (insertion-sort-helper nil list))

;; Helper function that maintains sorted and unsorted portions
(defun insertion-sort-helper (sorted-portion unsorted-portion)
  (cond 
    ;; Base case: No more unsorted items
    ;; Return the sorted portion
    ((null unsorted-portion) 
     sorted-portion)
    
    ;; Recursive case:
    ;; 1. Take first unsorted item
    ;; 2. Insert it into sorted portion
    ;; 3. Recursively process rest of unsorted items
    (t (insertion-sort-helper 
        (insert-into-sorted (car unsorted-portion) sorted-portion)
        (cdr unsorted-portion)))))

;; Test cases
(insertion-sort '())

(insertion-sort '(1))

(insertion-sort '(1 2 3 4 5))

(insertion-sort '(5 4 3 2 1))

(insertion-sort '(8 2 7 1 3 6 4 5))
