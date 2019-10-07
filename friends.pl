% Prolog is a declarative rules-based language designed to build the knowldge base that powers an expert system

% wallace, cheese, wendolene, and sheep are atoms, which are fixed values like symbols

% These are facts, which are direct obervations of the world
likes(wallace, cheese).
likes(grommit, cheese).
likes(wendolene, sheep).

% These are rules, which are logical inferences based on subgoals
% All subgoals must be true for the rule to be true.
% The rules ends in a period
% X, Y, Z are variables, which are uppercase or start with an underscore
% There are three subgoals delimited by commas
% /+ means logical negation

% This is the friend/2 rule.
% For X to be a friend of Y, they can't be the same atom (first subgoal) and they must both like an atom in common
friend(X, Y) :- \+(X = Y), likes(X, Z), likes(Y, Z).