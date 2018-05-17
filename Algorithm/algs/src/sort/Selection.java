
/******************************************************************************
 *  Compilation:  javac Selection.java
 *  Execution:    java  Selection < input.txt
 *  Dependencies: StdOut.java StdIn.java
 *  Data files:   https://algs4.cs.princeton.edu/21elementary/tiny.txt
 *                https://algs4.cs.princeton.edu/21elementary/words3.txt
 *   
 *  Sorts a sequence of strings from standard input using selection sort.
 *   
 *  % more tiny.txt
 *  S O R T E X A M P L E
 *
 *  % java Selection < tiny.txt
 *  A E E L M O P R S T X                 [ one string per line ]
 *    
 *  % more words3.txt
 *  bed bug dad yes zoo ... all bad yet
 *  
 *  % java Selection < words3.txt
 *  all bad bed bug dad ... yes yet zoo    [ one string per line ]
 *
 ******************************************************************************/
package sort;
import java.util.Comparator;

import algs.StdIn;
import algs.StdOut;

// 选择排序
public class Selection {

	private Selection() { }
	
	public static void sort(Comparable[] a) {
		int n = a.length;
		for (int i = 0; i < n; i++) {
			int min = i;
			for (int j = i+1; j < n; j++) {
				if (less(a[j],a[min])) min = j;
			}
			exch(a, i, min);
			assert isSorted(a, 0, i);
		}
		assert isSorted(a);
	}
	
	public static void sort(Object[] a, Comparator comparator) {
		int n = a.length;
		for (int i = 0; i < n; i++) {
			int min = i;
			for (int j = i+1; j < n; j++) {
				if (less(comparator, a[j], a[min])) min = j;
			}
			exch(a, i, min);
			assert isSorted(a, comparator, 0, i);
		}
		assert isSorted(a, comparator);
	}
	
	
	// helper sorting functions
	private static boolean less(Comparable v, Comparable w) {
		return v.compareTo(w) < 0;
	}
	private static boolean less(Comparator comparator, Object v, Object w) {
		return comparator.compare(v, w) < 0;
	}
	
	private static void exch(Object[] a, int i, int j) {
		Object swap = a[i];
		a[i] = a[j];
		a[j] = swap;
	}
	
	// check if array is sorted - useful for debugging
	
	private static boolean isSorted(Comparable[] a) {
		return isSorted(a,0,a.length-1);
	}
	private static boolean isSorted(Comparable[] a, int lo, int hi) {
		for (int i = lo + 1; i <= hi; i++) 
			if(less(a[i],a[i-1])) return false;
			return true;
	}
	private static boolean isSorted(Object[] a, Comparator comparator) {
		return isSorted(a, comparator, 0, a.length-1);
	}
	private static boolean isSorted(Object[] a, Comparator comparator, int lo, int hi) {
		for (int i = lo + 1; i <= hi; i++)
			if(less(comparator, a[i], a[i-1])) return false;
		return true;
	}
	private static void show(Comparable[] a) {
		for (int i = 0; i < a.length; i++) {
			StdOut.println(a[i]);
		}
	}
	
	
	
	public static void main(String[] args) {
		String[] a = StdIn.readAllStrings();
//		Selection.sort(a);
//		show(a);
		DescComparator comparator = new DescComparator();
		Selection.sort(a, comparator);
		show(a);

	}
}
class DescComparator implements Comparator<String>{
	 @Override
	    public int compare(String s1, String s2) {
	        return -s1.compareTo(s2);
	    }
}






