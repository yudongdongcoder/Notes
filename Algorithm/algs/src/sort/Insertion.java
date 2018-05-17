/******************************************************************************
 *  Compilation:  javac Insertion.java
 *  Execution:    java Insertion < input.txt
 *  Dependencies: StdOut.java StdIn.java
 *  Data files:   https://algs4.cs.princeton.edu/21elementary/tiny.txt
 *                https://algs4.cs.princeton.edu/21elementary/words3.txt
 *  
 *  Sorts a sequence of strings from standard input using insertion sort.
 *
 *  % more tiny.txt
 *  S O R T E X A M P L E
 *
 *  % java Insertion < tiny.txt
 *  A E E L M O P R S T X                 [ one string per line ]
 *
 *  % more words3.txt
 *  bed bug dad yes zoo ... all bad yet
 *
 *  % java Insertion < words3.txt
 *  all bad bed bug dad ... yes yet zoo   [ one string per line ]
 *
 ******************************************************************************/

package sort;

import java.util.Comparator;

import algs.StdIn;
import algs.StdOut;

public class Insertion {

	private Insertion() { }

	public static void main(String[] args) {
		String[] a = StdIn.readAllStrings();
	int[] index =	Insertion.indexSort(a);
	for (int i = 0; i < index.length; i++) {
		StdOut.println(index[i]);
	}
//		Insertion.sort(a);
//		show(a);
	}

	public static void sort(Comparable[] a) {
		int n = a.length;
		for (int i = 0; i < n; i++) {
			for (int j = i; j > 0 && less(a[j], a[j - 1]); j--) {
				exch(a, j, j - 1);
			}
			assert isSorted(a, 0, i);
		}
		assert isSorted(a);
	}
	
	
	public static void sort(Comparable[] a, int lo, int hi) {
		for (int i = lo; i < hi; i++) {
			for (int j = i; j>lo && less(a[j], a[j-1]); j--) {
				exch(a, j, j-1);
			}
		}
		assert isSorted(a);
	}


    public static void sort(Object[] a, Comparator comparator) {
    	int n = a.length;
    	for (int i = 0; i < n; i++) {
    		for (int j = i; j > 0 && less(a[j], a[j-1], comparator); j--) {
    			exch(a, j, j-1);
    		}
    		assert isSorted(a,0,i,comparator);
    	}
    	assert isSorted(a,comparator);
    }
	
    public static void sort(Object[] a, int lo, int hi, Comparator comparator) {
    	for (int i = lo; i < hi; i++) {
            for (int j = i; j > lo && less(a[j], a[j-1], comparator); j--) {
                exch(a, j, j-1);
            }
        }
        assert isSorted(a, lo, hi, comparator);
    }
    
    public static int[] indexSort(Comparable[] a) {
    	 int n = a.length;
         int[] index = new int[n];
         for (int i = 0; i < n; i++)
             index[i] = i;

         for (int i = 0; i < n; i++)
             for (int j = i; j > 0 && less(a[index[j]], a[index[j-1]]); j--)
                 exch(index, j, j-1);

         return index;
    	
    }
	// helper sorting functions
	private static boolean less(Comparable v, Comparable w) {
		return v.compareTo(w) < 0;
	}

	private static boolean less(Object v, Object w, Comparator comparator) {
		return comparator.compare(v, w) < 0;
	}

	private static void exch(Object[] a, int i, int j) {
		Object swap = a[i];
		a[i] = a[j];
		a[j] = swap;
	}

	private static void exch(int[] a, int i, int j) {
		int swap = a[i];
		a[i] = a[j];
		a[j] = swap;
	}

	// check if array is sorted

	private static boolean isSorted(Comparable[] a) {
		return isSorted(a, 0, a.length);
	}

	private static boolean isSorted(Comparable[] a, int lo, int hi) {
		for (int i = lo + 1; i < hi; i++)
			if (less(a[i], a[i - 1]))
				return false;
		return true;
	}

	private static boolean isSorted(Object[] a, int lo, int hi, Comparator comparator) {
		for (int i = lo + 1; i < hi; i++)
			if (less(a[i], a[i - 1], comparator))
				return false;
		return true;
	}

	private static boolean isSorted(Object[] a, Comparator comparator) {
		return isSorted(a, 0, a.length, comparator);
	}

	private static void show(Comparable[] a) {
		for (int i = 0; i < a.length; i++) {
			StdOut.println(a[i]);
		}
	}
}
