'''
Phoebe Hughes and Jenny Lin
Project 8
sortArrayP.py
Sorts an array using parallelism and qsort
'''
 
import time
import threading
import random				

class SortArray:
	def __init__(self, array, numThreads, compFunc):
		self.array= array
		self.numThreads = numThreads
		self.compFunc= compFunc
	
	def getArray(self):
		return self.array
	
	def getNumThreads(self):
		return self.numThreads
	
	def bubbleSort(self, startInd, endInd):
		'''Uses bubble sort to sort a section of the array'''
		for i in range(startInd, endInd):
			for j in range(i+1, endInd):
				if (self.compFunc(self.array[i], self.array[j]) > 0):
					temp = self.array[i]
					self.array[i] = self.array[j];
					self.array[j] = temp


	def parallelSort(self):
		threads = []
		
		start = 0
		remainder = len(self.array)%self.numThreads
		sizeSub = (len(self.array)- remainder)/self.numThreads
		
		for i in range(self.numThreads):
			end = start+sizeSub
			if i- remainder < 0:
				end += 1
		
			t = threading.Thread(name = str(i), target=self.bubbleSort, args=(start, end,))
			threads.append(t)
			
			start= end
		
		#each thread work
		for t in threads:
			t.start()
		
		#all threads must join
		for t in threads:
			t.join()
		
		start = 0
		
		for i in range(self.numThreads):
			sizeArray = sizeSub
			
			if i-remainder < 0: 
				sizeArray +=1
				
			#sort the next segment
			start1 = 0
			start2 = start
			temp = []
			while (start1 < start and start2 < (sizeArray + start)):
				#Choose which to add
				if (self.compFunc(self.array[start1], self.array[start2]) < 0):
					temp.append(self.array[start1])
					start1+=1
				else:
					temp.append(self.array[start2])
					start2+=1
			
			if start1 == start:
				temp += self.array[start2:(sizeArray+start)]
			elif start2 == (sizeArray + start):
				temp += self.array[start1:start]
		
			
			#save temp into array
			self.array[0:(sizeArray+start)] = temp
			
			start = sizeArray + start
	

def compareInts(a, b):
	'''Compares two integers'''
	return a-b

	
def runSort(size, numRuns, numThreads):
	averageTime = 0.0
	for i in range(numRuns):
		array = []
		for j in range(size):
			array.append(random.randint(0, size*2))
			
		#print "Before Sorting: ", array
	
		sa = SortArray(array, numThreads, compareInts)
	
		sTime = time.time()
	
		sa.parallelSort();
	
		eTime = time.time()
	
		elasped = eTime-sTime
		averageTime += elasped
		
		#print "After Sorting: ", sa.getArray()
		#print "Time to Sort using %d Threads was %ds" % (numThreads, elasped)
	
	averageTime /= numRuns
	print "Average time to sort array of size %d using %d Threads was %ds" % (size, numThreads, averageTime)

		


def main():
	numTimes = 5
	numThreads = [1, 2, 3, 4, 6, 10, 20, 100, 1000]
	sizes = [5000, 10000, 7500, 15000]
	
	for i in range(len(sizes)):
		print "Size Array: ", sizes[i]
		for j in range(len(numThreads)):
			runSort(sizes[i], numTimes, numThreads[j])
	

if __name__ == '__main__':
	main()

