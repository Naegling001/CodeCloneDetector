package com.github.mihirsinghal.cricket;

import javax.swing.*;
import java.util.*;

public class Functions {

	final static String UNIMPLEMENTED = Functions.red("Unimplemented");

	public static String red(String st) {
		return String.format("<html><font color=\"red\"><b>%s</b></font></html>", st);
	}

	public static String bold(String st) {
		return String.format("<html><b>%s</b></html>", st);
	}

	public static String size(String st, float size) {
		return String.format("<html><span style=\"font-size:%fem\">%s</span></html>", size, st);
	}

	public static String boldSize(String st, float size) {
		return String.format("<html><span style=\"font-size:%fem\"><b>%s</b></span></html>", size,
				st);
	}

	public static boolean isValidName(String st) { // Valid names are composed
													// only of letters, numbers,
													// and spaces
		for (char c: st.toCharArray()) {
			if (!Character.isAlphabetic(c) && !Character.isDigit(c) && c != ' ') {
				return false;
			}
		}
		return true;
	}

	public static <T> int indexInArray(T[] array, T elem) {

		for (int i = 0; i < array.length; i++) {
			if (array[i] == elem) {
				return i;
			}
		}

		return -1;

	}

	public static <T> List<T> listFromArray(T[] array) {

		List<T> ans = new ArrayList<T>();

		for (T elem: array) {
			ans.add(elem);
		}

		return ans;

	}

	public static <T> List<T> listWithoutElem(List<T> ls, T elem) {

		List<T> ans = new ArrayList<T>(ls);

		if (!ans.remove(elem)) {
			System.out.println("Error in listWithoutElem: List did not contain element");
		}

		return ans;

	}

	public static <T> List<T> listWithoutElem(T[] ls, T elem) {

		return listWithoutElem(listFromArray(ls), elem);

	}

	public static <T> List<T> listSubtract(List<T> ls1, List<T> ls2) {

		List<T> ans = new ArrayList<T>();
		
		for (T elem: ls1) {
			if (!ls2.contains(elem)) {
				ans.add(elem);
			}
		}
		
		return ans;

	}
	
	public static <T> List<T> listSubtract(T[] ls1, List<T> ls2) {

		List<T> ans = new ArrayList<T>();
		
		for (T elem: ls1) {
			if (!ls2.contains(elem)) {
				ans.add(elem);
			}
		}
		
		return ans;

	}
	
	public static <T> List<T> listSubtract(List<T> ls1, T[] ls2) {

		List<T> ans = new ArrayList<T>();
		
		for (T elem: ls1) {
			if (indexInArray(ls2, elem) == -1) {
				ans.add(elem);
			}
		}
		
		return ans;

	}
	
	public static <T> List<T> listSubtract(T[] ls1, T[] ls2) {

		List<T> ans = new ArrayList<T>();
		
		for (T elem: ls1) {
			if (indexInArray(ls2, elem) == -1) {
				ans.add(elem);
			}
		}
		
		return ans;

	}

	public static int max(int a, int b) {
		return (a > b) ? a : b;
	}

	public static void setUnimplemented(JButton but) {
		but.setText(UNIMPLEMENTED);
	}

	public static String ballsToOvers(int balls) {
		if (balls % 6 == 0) {
			return Integer.toString(balls / 6);
		} else {
			return balls / 6 + "." + balls % 6;
		}
	}
	
	public static int arraySum(int[] ls) {
		
		int ans = 0;
		for (int n: ls) {
			ans += n;
		}
		
		return ans;
	}

}
