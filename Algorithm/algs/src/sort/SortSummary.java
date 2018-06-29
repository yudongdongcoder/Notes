package sort;

import algs.StdIn;
import algs.StdOut;
public class SortSummary {

	static void show(Comparable[] a) {
		for (int i = 0; i < a.length; i++) {
			StdOut.println(a[i]);
		}
	}
	
	public static void  main(String[] args) {
		String[] a = StdIn.readAllStrings();
		Selection.sort(a);
		show(a);
	}
	
}


class Selection extends SortBase { 
	
	static void sort(Comparable[] a) {
		int n = a.length;
		for (int i = 0; i < n; i++) {
			int min = i;
			for (int j = i+1; j < n; j++) {
				if (less(a[j], a[min])) min = j;
			}
			exch(a, i, min);
			assert isSorted(a, 0, i);
		}
		
		assert isSorted(a);
	}
}

class Insertion extends SortBase{
	
	static void sort(Comparable[] a) {
		int n = a.length;
		for (int i = 0; i < n; i++) {
			for(int j = i; j > 0 && less(a[j], a[j-1]); j--) {
				exch(a, j, j-1);
			}
			assert isSorted(a, 0, i);
		}
		
		assert isSorted(a);
	}
}


class Shell extends SortBase{
	
	static void sort(Comparable[] a) {
		int n = a.length;
		
		int h = 1;
		while(h < n/3) h = 3*h + 1;
		
		while(h >= 1) {
			
			for (int i = h; i < n; i++) {
				for(int j = i;j >= h && less(a[j], a[j-h]); j -= h ) {
					exch(a, j, j-h);
				}
			}
			h /= 3;
			assert isHSorted(a, h);
		}
		assert isSorted(a);
	}
}


class SortBase {
	
	static boolean less(Comparable v, Comparable w) {
		return v.compareTo(w) < 0;
	}
	
	static void exch(Object[] a, int i, int j) {
		Object swap = a[i];
		a[i] = a[j];
		a[j] = swap;
	}
	
	static boolean isSorted (Comparable[] a) {
		return isSorted(a, 0, a.length-1);
	}
	
	static boolean isSorted (Comparable[] a, int lo, int hi) {
		for (int i = lo + 1; i <= hi; i++)
			if (less(a[i], a[i-1])) return false;
		return true;
	}
	
	static boolean isHSorted(Comparable[] a, int h) {
		for (int i = h; i < a.length; i++) 
			if(less(a[i], a[i-h])) return false;
		return true;
	}

}









