#!/usr/bin/perl

#
# Author      : Harman Birdi
# Date        : Sep 13, 2016
# Description : Program to determine if a string comprising of different kinds
#               of brackets is balanced or not. The string is determined to be
#               balanced if all sequences of brackets match adjacently or in
#               a nested format. The brackets that can be used are '(', ')'
#
#               Please note that brackets that are mix of adjacent and nested
#               will NOT return as balanced like ()(())
#
#               Finally, this likely is NOT the best solution. Best solution
#               would also cover the mixed case, but that was not explicitly
#               asked for or stated in the problem statement.
#
#               The solution does NOT make any difference from the previous one
#               which had additional types of brackets. It works exactly as the
#               last one though the code to check for additional types of
#               brackets has been removed.
#

use strict;
use warnings FATAL => 'all';

#
# Subroutine to checks for adjacent pair of parenthesis where only characters next
# to each other are complementary. It return 0 for FALSE, else return 1 for TRUE.
#
sub adjacent {
    my @chars = split('', $_[0]);
    my @stack = ();

    foreach my $char (@chars) {
        if (scalar @stack == 0) {
            push(@stack, $char);
        } elsif (scalar @stack == 1) {
            my $pop_char = pop(@stack);
            if (($char eq '(' and $pop_char ne ')')) {
                return 0;
            }
        }
    }

    return 1;
}

#
# Subroutine to checks for nested pair of parenthesis where the innermost
# characters would be matching braces, followed by next set moving outwards.
#
sub nested {
    my @queue = split('', $_[0]); # Create queue of the string characters
    my @stack = ();

    if (scalar(@queue) % 2 != 0) {
        return 0;
    }

    @stack = reverse(@queue); # Creates its stack by reversing the string

    # Compare first element of queue and see if its complementary character
    # is NOT part of the stack at same position for all elements. If so,
    # return 0 for FALSE, else return 1 for TRUE when the loop finishes.
    for (my $i = 0 ; $i < scalar @queue; $i++) {
        if (($queue[$i] eq '(' and $stack[$i] ne ')')) {
            return 0;
        }
    }

    return 1;
}

#
# Subroutine to return 0 for FALSE or 1 for TRUE is the brackets are balanced.
#
sub balanced {
    return (nested($_[0]) or adjacent($_[0]));
}

#
# Main starts here
#
my @arr = ('(())', '(()(', '()()()()', '()(())');

foreach my $str (@arr) {
    if (balanced($str)) {
        print "String \'". $str ."\' is balanced.\n";
    } else {
        print "String \'". $str ."\' is NOT balanced.\n";
    }
}