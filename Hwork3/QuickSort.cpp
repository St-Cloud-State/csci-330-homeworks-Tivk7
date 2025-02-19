#include <stack>
#include <utility>
#include <iostream>

// Swaps two integers in the array
// Parameters:
//   a, b: References to the integers to be swapped
 void swap(int& a, int& b){
    int temp = a;
    a = b;
    b = temp;
 }

// Partitions the array around a pivot using Lomuto's partition scheme
// Parameters:
//   arr[]: Array to be partitioned
//   low: Starting index of the partition
//   high: Ending index of the partition
// Returns:
//   The final position of the pivot element
 int partition(int array[], int low, int high){
     // Select rightmost element as pivot
    int pivot = array[high];

    // Index of smaller element, starts before first element
    int i = low - 1;

    // Iterate through array from low to high-1
    for (int j = low; j < high; j++){
         // If current element is smaller than or equal to pivot
        if (array[j] <= pivot){
             // Move the smaller element index forward
            i++;
            // Swap current element with element at smaller element index
            swap(array[i], array[j]);
        }
    }
    // Place pivot in its final position
    swap(array[i + 1], array[high]);

    // Return the position of the pivot
    return i + 1;
 }

// Iterative QuickSort function using a stack
// Parameters:
//   arr[]: Array to be sorted
//   size: Size of the array
 void quickSort(int array[], int size){
    // Create a stack of pairs to store ranges (low, high)
    std::stack<std::pair<int, int>> st;

    // Push initial range of the entire array
    st.push(std::make_pair(0, size - 1));

    while (!st.empty()){
        // Get the range from top of stack
        int low = st.top().first;
        int high = st.top().second;
        // Remove the range from stack
        st.pop();

        // Get pivot's final position through partitioning
        int pivot_index = partition(array, low, high);

        // If elements exist on right side of pivot,
        // push right side range to stack
        if (pivot_index + 1 < high){
            st.push(std::make_pair(pivot_index + 1, high));
        }
        
        // If elements exist on left side of pivot,
        // push left side range to stack
        if (low < pivot_index - 1){
            st.push(std::make_pair(low, pivot_index - 1));
        }
    }
 }

 int main(){
    //Example array the needs sorting
    int array[] = {10, 4, 8, 1, 5, 3, 0, 9};
    int size = sizeof(array) / sizeof(array[0]);

    // Print original array
    std::cout << "Original array: ";
    for (int i = 0; i < size; i++) {
        std::cout << array[i] << " ";
    }
    
    // Sort the array
    quickSort(array, size);
    
    // Print sorted array
    std::cout << "\nSorted array: ";
    for (int i = 0; i < size; i++) {
        std::cout << array[i] << " ";
    }
    
    return 0;
 }