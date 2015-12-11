'''
Phoebe Hughes and Jenny Lin
colorize.py
Applies filter to ppm using parallelism and sequentially
'''

import sys
import time
import threading
import Image #must have PIL installed

def purpleGrayDots(src, startCols, endCols, rows):
	'''Turns pixels with high blue value purple and all others gray.'''
	for x in range(startCols, endCols):
		for y in range(rows):
			r,g,b = src[x,y]
			#making dots
			if (x%20 == 0 and y%20 == 0):
				for g in range(5):
					for h in range(5):
						if not(x+g >= endCols) and not(y+h >= rows): 
							src[x+g,y+h]= (0,0,0)
			
			#purple and gray
			if b<150:
				src[x,y]= (g,r,150)
			else:			
				ave=(r+g+b)/3
				src[x,y] = (ave,ave,ave)

def parallelizeColorizing(src, numThreads, totalCols, rows):
	'''Applying filter to image using parallelism'''
	#deciding how many columns to process
	remainder = totalCols%numThreads
	size = (totalCols - remainder)/numThreads
	startCols = 0
	endCols = size
	
	threads = []
	#setting up each thread
	for i in range(numThreads):
		if ( i - remainder < 0 ):
			endCols+=1
		t = threading.Thread(name = str(i), target=purpleGrayDots, args=(src, startCols, endCols, rows,))
		threads.append(t)
		
		startCols = endCols
		endCols+=size
	
	#each thread work
	for t in threads:
		t.start()
	
	#all threads must join
	for t in threads:
		t.join()
	

def main(argv):
	'''Colorizes ppm and then saves and displays it'''
	if len(argv) < 3:
		print "Usage: python colorize.py <ppm> <numThreads>"
		exit()
	
	aveTime = 0
	for i in range(5):
		#setting up original image
		src = Image.open(argv[1])
		cols = src.size[0]
		rows = src.size[1]
		srcLoaded = src.load()
		numThreads = int(argv[2])
		
		#timing and running colorizing
		sTime = int(round(time.time() * 1000))
		parallelizeColorizing(srcLoaded, numThreads, cols, rows)
		eTime = int(round(time.time() * 1000))
		
		aveTime += (eTime-sTime)
	
	aveTime/=5
	
	print "Average time to colorize %dms using %d threads" % (aveTime, numThreads)
	
	#save and display ppm
	nameDst = 'purple.ppm'
	src.save( nameDst )


if __name__ == '__main__':
	main(sys.argv)