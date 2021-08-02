/*
spanning-trees
xdobis01
Lukas Dobis
FLP 2021
*/

main :-
		prompt(_, ''),
		read_lines(LL), !,
		split_lines(LL,S), !,
		parse_graph(S), ! -> 
		(
          compute_spanning_trees(T), ! -> print_spanning_trees(T), nl, free, halt
          ;
          writeln('ERROR: Unknown spanning tree computation error.'), nl, free, halt
        ) 
        ; writeln('ERROR: Invalid format of the input unoriented graph.'), nl,
          writeln('USAGE: ./spanning-tree < GRAPH_FILE'),nl,
          print_example, nl, free, halt.

% ============================================================================== 
% Computation of spanning trees
% ==============================================================================

% Computes from edge predicates all possible spanning trees 
compute_spanning_trees(Trees) :- get_nodes(Nodes), 
                                 length(Nodes,Len),
                                 edge(X,_), 
                                 setof(Tree, get_edges(Len - 1, Len, [X], [], Tree), Trees).

% Get all nodes as list 
get_nodes(Nodes) :- setof(X, Y^(edge(X,Y); edge(Y,X), X \== Y), Nodes).

% Computes from edge predicates spanning tree
% EL - Edge length - number of (remaining) edges to be added to tree structure
% NL - Node length - number of nodes in tree
% Used - Used nodes - unique nodes in tree structure
% Tree - Structure representing tree
% Out - Output - parameter to return constructed tree structure 
get_edges(EL, NL, Used, Tree, Out) :- EL == 0, 
                                      length(Used,Len), 
                                      Len == NL, 
                                      sort(Tree,Out).
get_edges(EL, NL, Used, Tree, Out) :- EL_ is EL - 1,
                                      edge(N1,N2),
                                      (member(N1,Used);member(N2,Used)),
                                      not(member(N1-N2,Tree)),
                                      sort([N1,N2|Used],Used_),
                                      get_edges(EL_, NL, Used_, [N1-N2|Tree], Out).

% ============================================================================== 
% Unoriented graph validation
% ============================================================================== 

% Dynamic predicate representing edge as a binary relation of two nodes.
:- dynamic edge/2.

% Cleans up created dynamic edges.
% free/0
free :- retractall(edge(_, _, _, _)).

% Creates unoriented graph as edges and validates input
parse_graph([[[Node1],[Node2]]|Lines]) :-
                               node(Node1), node(Node2),
                               !,
                               assertz(edge(Node1, Node2)),
                               (Lines == [];
                                parse_graph(Lines)
                               ).

% True if input character is valid character for a node.
node(C) :-
  member(C, [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
    'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ]).

% ============================================================================== 
% I/O operations
% ============================================================================== 

% Reads line from standard input, terminates on LF or EOF.
read_line(L,C) :-
	get_char(C),
	(isEOFEOL(C), L = [], !;
		read_line(LL,_),% atom_codes(C,[Cd]),
		[C|LL] = L).

% Tests if character is EOF or LF.
isEOFEOL(C) :-
	C == end_of_file;
	(char_code(C,Code), Code==10).

% Reads lines from standard input.
read_lines(Ls) :-
	read_line(L,C),
	( C == end_of_file, Ls = [] ;
	  read_lines(LLs), Ls = [L|LLs]
	).

% Splits line into lists
split_line([],[[]]) :- !.
split_line([' '|T], [[]|S1]) :- !, split_line(T,S1).
split_line([32|T], [[]|S1]) :- !, split_line(T,S1).    
split_line([H|T], [[H|G]|S1]) :- split_line(T,[G|S1]). 

% Splits lines into lists
split_lines([],[]).
split_lines([L|Ls],[H|T]) :- split_lines(Ls,T), split_line(L,H).

% Prints out spanning trees to standard output
print_spanning_trees([]) :- !.
print_spanning_trees([H|T]) :- forall( member(C, H), (write(C),write(' ')) ), 
                               nl, 
                               print_spanning_trees(T).
                               
% Prints out example of correct input graph format to standard output
print_example :- writeln('GRAPH_FILE example:\nA B \nA C \nA D \nB C \nC D').
