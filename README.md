# Tournament-Branch-Predictor
This project uses C++ to simulate bimodal, gshare, and tournament branch predictors. 

In this directory are three .txt files containing a few million rows of instruction addresses and whether or not that branch was taken, expected results (given by course instructor), and results files that are populated by running this program. 

Bimodal branch predictors map branch instructions to a table that holds information about previous requests. This mapping is done by taking a certain number of rightmost digits as the index. I test different types of counters to store that information, and we can analyze the improved accuracy. 

Gshare branch predictors index instructions by taking rightmost digits applying XOR with a global history register (GHR), which updates and changes based on prediction accuracy. The GHR adds a level of complexity and memory to the bimodal branch predictor, and we examine the impact of different sized GHRs. 

A tournament branch predictor adds another layer of memory on top of the bimodal and gshare predictors. Each instruction has a counter that will hold information about previous instructions to pick which predictor to use, and both those predictors will have their individual counters that are updated after each prediction. 

More specifics on the different variables changed for each predictor down below. 

This project is from Binghamton University’s CS 320, Advanced Computer Architecture. 

This code is 100% original, and the test files and expected outputs were given by the course instructor. 

# Table of contents
- [Files](#files)
- [How To Use](#how-to-use)
- [Specifics](#specifics)

# Files
1. `predictors.cpp` is the predictor program.

2. `Makefile` holds instructions to compile and clean.

3. `3_bit_states.png` shows the state diagram our 3-bit bimodal counter uses.

4. `traces/` contains .txt files of instructions and their corresponding results to run our predictors on.

5. `expected/` contains expected branch prediction results.

6. `results/` contains .txt files that our program writes to.

# How To Use
1. In this directory, run...
    ```
    $ make
    ```

2. To test this on any trace, run...
    ```
    $ ./predictors traces/filename results/name
    ```
    For example...
    ```
    $ ./predictors traces/short_trace1.txt results/short1.txt
    ```
    ```
    $ ./predictors traces/short_trace2.txt results/short2.txt
    ```
    ``` 
    $ ./predictors traces/short_trace3.txt results/short3.txt
    ```

3. Examine the results file with the corresponding expected results file.

4. When you’re finished…
    ```
    $ make clean
    ```

# Specifics

1. Line 1 of the output is `Taken; Total`

2. Line 2 of the output is `Not Taken; Total`

Note: The rest of the output uses the form `Predicted; Total`

3. Lines 3, 4, and 5 are the results of bimodal branch predictors with 1, 2, and 3 bit counters, respectively.
    - 1-bit counters are updated with the executed branch’s result.
    - 2-bit counters implement a saturating counter that utilizes “weak” and “strong” states. 
    - 3-bit counters follow a specific state diagram, located in 3_bit_states.png.
    - For each counter/line of output, there are 7 entries, simulating the use of using 2, 3, 5, 6, 8, 10, and 12 bit indexes, respectively. 
        - Notice how for all three, accuracy seems to increase linearly with more index bits.

4. Line 6 is the result of a gshare branch predictor with a 2-bit saturating counter and 12-bit index. There are 10 entries in this line, representing the use of GHRs with 2-12 bits. 
    - Notice how accuracy drops off as we reach 12 bits.


5. Line 7 is the result of a tournament branch predictor with a 2-bit saturating counter to pick between a gshare and bimodal branch predictor and a 12-bit index. 
    - The tournament counters are initialized to 00, which strongly favors the bimodal predictor
    - The bimodal table uses the 3-bit counter scheme used in line 5
    - The gshare table uses a 2-bit saturating counter and 12-bit GHR
    - All branch predictors use a 12-bit index i.e. the rightmost 12 bits

In general more specificity/complexity/information retained is better for accuracy. However, an exception is the size of GHR bits, as accuracy seems to taper off as we get to 12 bits. 
