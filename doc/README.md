# Functional and Logic Programming - Logical Project
## SPANNING-TREES
### 2021
#### Author: Lukas Dobis <xdobis01@stud.fit.vutbr.cz>

## Build
Using `make` command the project is compiled using the `swipl` compiler
into `spanning-trees` executable. To showcase simple example use `make run`
to print computed spanning-trees from test/test01.in file. Running command 
`make tests`, generates test results described in `doc/test-description.txt` file.
Command `make clean` can be used to clear test outputs, while `make reset`
does same, but with additional removal of executable.

## Run

```bash
$ ./spanning-trees [STDIN]
```
Program assumes that it will receive unoriented graph from standard input. 
Graph is represented in format of multiple edges, where two alphabetic nodes 
on one line represent one edge.

Example of expected graph format on standard input: 

A B
A C
A D
B C
C D

## Description
The program computes all spanning trees for inputted unriented graph. 
After computation program prints trees on standard output in alphabetic order.
In event of incorrect input or error during computation, program prints
error string and terminates.

- `spanning-trees.pl` - The main program performs:- 
													reading standard input,
													validating input format,
													parsing unoriented graph,
													computing spanning trees,
													printing spanning trees.
