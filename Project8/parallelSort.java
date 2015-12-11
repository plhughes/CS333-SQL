/* Authors: Jenny Lin & Phoebe Hughes
 * CS333 Project 8
 * Task 1 (Extension)
 * Split array even amongst N threads, sort using quick sort, merge
 * Array's are of type Comparable so that we can utilize their compareTo
 * during the sorting process
 * Compile with javac parallelSort.java
 */

import java.util.*;

public class parallelSort{

    //swaps two elements in place
    private static void swapContent( Comparable[] array, int a, int b ){
	Comparable temp = array[a];
	array[a] = array[b];
	array[b] = temp;
    }

    // sorts a[start] to a[end] in place
    private static void quickSort( Comparable[] array, int start, int end ){
	//partition the list
	Comparable pivot = array[(start+end)/2];
	int i = start;
	int j = end;

	do{
	    while(array[i].compareTo(pivot) < 0)
		i++; // skip over values already in the right half of the list
	    while(pivot.compareTo(array[j]) < 0)
		j--; // skip over values already in the right half of the list
	    if(i <= j) { 
		//swap array[i] and array[j] because they are 
		//in incorrect "halves" of list
		swapContent(array, i, j);
		i++;
		j--;
	    }
	} while(i<=j); //repeat until indices cross

	//sort recursively
	if(start < j)
	    quickSort(array, start, j);
	if(i < end)
	    quickSort(array, i, end);
    }

    /* Given the start and end indices that each thread is in charge of, 
       this will merge the partially sorted array by taking the smallest of 
       the partially sorted array and add it to the front of the final array */
    private static void merge( Comparable[] array, int numThreads, 
			       int[] startIdx, int[] endIdx ){
	Comparable[] newArray = new Comparable[array.length]; //holds sorted array
	Comparable smallest = null;
	int threadNum;

	for(int i=0; i<array.length; i++){
	    threadNum = -1; //set to invalid value to indicate we dont have the smallest
	    
	    //Loop through each thread's sorted array's first element to find the 
	    //smallest one
	    for(int j=0; j<numThreads; j++){
		
		//if the sorted segment still has content left
		if(startIdx[j] <= endIdx[j]){
		    //if we didnt set a default smallest value, do it now
		    if(threadNum == -1){
			threadNum = j;
			smallest = array[startIdx[j]];
		    }
		    
		    //comparing smallest to other sorted segment's smallest value
		    if(smallest.compareTo(array[startIdx[j]]) > 0){
			smallest = array[startIdx[j]];
			threadNum = j;
		    }
		}
	    }
	    
	    //add to final sorted array
	    newArray[i] = smallest;
	    //increase the start index for that sorted segment
	    startIdx[threadNum]++;
	}

	//Copy back into our original array
	for(int i=0; i<array.length; i++)
	    array[i] = newArray[i];

    }

    /* Holds infomation relevant to task that each thread needs to perform */
    public static class ThreadInfo extends Thread{
	
	private Comparable[] array; //array being sorted
	private int start, end; //segment of array that thread is responsible for
	
	//Constructor
	public ThreadInfo(Comparable[] array, int start, int end){
	    this.array = array;
	    this.start = start;
	    this.end = end;
	}

	//Calls the the quickSort method 
	@Override
	public void run() {
	    quickSort(this.array,this.start,this.end);
	}
    }	

    //Takes in an array and the number of threads used for parallelization
    private static void parallelSort(Comparable[] array, int numThreads){
	ThreadInfo[] threads = new ThreadInfo[numThreads];
	int[] startIdx = new int[numThreads];
	int[] endIdx = new int[numThreads];

	//Create, initialize and start threadInfo
	for(int i=0; i<numThreads; i++){
	    startIdx[i]  = i*array.length/numThreads;
	    endIdx[i] = (i+1)*array.length/numThreads - 1;
	    threads[i] = new ThreadInfo( array, startIdx[i], endIdx[i] );
	    threads[i].start(); //start the thread
	}

	//join the threads
	for(ThreadInfo t: threads){
	    try {
		t.join();
	    } catch (InterruptedException e) {
		e.printStackTrace();
	    }
	}

	//Merge the final array
	merge(array, numThreads, startIdx, endIdx);
    }

    /* We will run the parallel sort using up to the given number of threads. 
       This will take in the length of an array and will print out the time elapsed */
    private static void calcTime(int numThreads, int length){
	long tStart, tEnd;
	Random r = new Random();
	Comparable[] array = new Comparable[length];

	for(int i=1; i<=numThreads; i++){
	    //populating array
	    for(int j=0; j<length; j++)
		array[j] = (Comparable)r.nextInt();
	    tStart = System.nanoTime();
	    parallelSort(array, numThreads);
	    tEnd = System.nanoTime();
	    System.out.println(length + "," + Integer.toString(i)+","
			       + Long.toString((tEnd-tStart)/1000000));
	}
    }

    public static void main(String[] args){

	//Sorting small array using paralle sort to demonstrate that it works
	/*
	Random rand = new Random();
	Comparable[] array = new Comparable[10];

	for(int i=0; i<10; i++){
	    array[i] = (Comparable)rand.nextInt(100);
	}

	System.out.println("Before Sorting");
	for(int i=0; i<10; i++){
	    System.out.print(array[i]+" ");
	}
	parallelSort(array, 2);
	System.out.println("\nAfter Sorting");
	for(int i=0; i<10; i++){
	    System.out.print(array[i]+" ");
	} 
	System.out.println();
	*/
	//Generates the run time
	//Suggests to comment block above, uncomment block below
	//compile with javac parallelSort.java
	//and run with java parallelSort > javaStats.csv 
	//to see the data in spread sheet
	
	System.out.println("Array Size,Thread,Time (ms)");
	for(int i=1; i<13; i++){
	    calcTime(8, (10000*i));
	}
	
    }
}
