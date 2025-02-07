# Tournament-Branch-Predictor
This project uses C++ to simulate bimodal, gshare, and tournament branch predictors. 

This project is from Binghamton University’s CS 320.

# Table of contents
- [Specifics](#specifics)
- [How To Use](#how-to-use)
- [Files](#files)

# Specifics
Bimodal branch predictors are simulated with 1-3 bit counter configurations and 2, 3, 5, 6, 8, 10, and 12 bit indexes. 

1-bit counters are updated with the executed branch’s result.
2-bit counters implement a saturating counter that utilizes “weak” and “strong” states. 
3-bit counters follow a specific state diagram, located in 3_bit_states.png.

Gshare branch predictors are simulated with a 2-bit saturating counter configuration and 12-bit index with 2-12 bit global history registers(GHR) initialized to 0…01. 

The tournament branch predictor uses a 12-bit selector table with 2-bit saturating counters, initialized to 00, which represents strongly picking the bimodal prediction. A 3-bit counter bimodal table initialized and a 2-bit saturating counter gshare table with a global history register initialized to 0. All predictors in this tournament branch utilize a 12-bit index. 

The program is test on .txt files containing millions of instructions in the form `0xXXXXXXXX T` or `0xXXXXXXXX NT`, indicating taken or not taken. For each individual predictor, we output the correct predictions made and the total instructions predicted. The results are compared to expected files, provided by the instructor.

# How To Use
In the repository…
```
$ make
```
To run it on any trace…
```
$ ./predictors traces/filename results/name
```
More specifically…
```
$ ./predictors traces/short_trace1.txt results/short1.txt
```
```
$ ./predictors traces/short_trace2.txt results/short2.txt
```
``` 
$ ./predictors traces/short_trace3.txt results/short3.txt
```

When you’re finished…
```
$ make clean
```

# Files
`predictors.cpp` is the predictor program.

`Makefile` holds instructions to compile an clean.

`3_bit_states.png` shows the state diagram our 3-bit counter uses.

`traces/` contains .txt files of instructions and their corresponding results to run our predictors on.

`expected/` contains expected branch prediction results.

`results/` contains .txt files to write to.
