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

// 选择排序
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

// 插入排序
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

// 希尔排序
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

// 归并排序

class Merge extends SortBase {
	
	
	
	
	// 自定向下的归并排序
	static void sortUB(Comparable[] a) {
		Comparable[] aux = new Comparable[a.length];
		sortUB(a, aux, 0, a.length-1);
		assert isSorted(a);
	}
	
	private static void sortUB(Comparable[] a, Comparable[] aux, int lo, int hi) {
		
		if (hi <= lo) return;
		int mid = lo + (hi-lo)/2;
		sortUB (a, aux, lo, mid);
		sortUB (a, aux, mid+1, hi);
		merge(a, aux, lo, mid, hi);
	}
	
	
	 static void sortBU(Comparable[] a) {
		
		 int n = a.length;
		 Comparable[] aux = new Comparable[n];
		 
		 for (int len = 1; len < n; len *=2) {
			 for (int lo = 0; lo < n-len; lo += len+len) {
				 int mid = lo+len-1;
				 int hi = Math.min(lo+len+len-1, n-1);
				 merge(a, aux, lo, mid, hi);
			 }
		 }
		 
		 assert isSorted(a);
	}

	private static void  merge(Comparable[] a, Comparable[] aux, int lo, int mid, int hi) {
		
		assert isSorted(a, lo, mid);
		assert isSorted(a, mid+1, hi);
		
		for (int i = lo; i <= hi; i++) aux[i] = a[i];
		
		int i = lo, j = mid+1;
		for (int k = lo; k <= hi; k++) {
			if			(i > mid) 				a[k] = aux[j++];
			else if 	(j > hi) 				a[k] = aux[i++];
			else if		(less(aux[i], aux[j])) 	a[k] = aux[i++];
			else								a[k] = aux[j++];
		}
		
		assert isSorted(a, lo, hi);
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









