all: predictors

predictors: predictors.o
	g++ predictors.o -o predictors

predictors.o: predictors.cpp
	g++ -c predictors.cpp

clean: 
	rm -f *o predictors
	truncate -s 0 results/short1.txt results/short2.txt results/short3.txt