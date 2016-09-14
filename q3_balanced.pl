#!/usr/bin/perl

#
# Author      : Harman Birdi
# Date        : Sep 13, 2016
# Description : Program to determine if a string comprising of different kinds
#               of brackets is balanced or not. The string is determined to be
#               balanced if all sequences of brackets match adjacently or in
#               a nested format. The brackets that can be used are '(', ')',
#               '{', '}', '[' and ']'
#
#               Please note that this solutions covers mixed adjacent and
#               nested cases as well like ({}[])
#

use strict;
use warnings FATAL => 'all';

#
#  This subroutine checks if the brackets are balanced and returns 0 for FALSE
#  else it returns 1 for TRUE.
#
sub balanced {
    my @chars = split('', $_[0]); # Create queue of the string characters
    my @stack = ();

    # If length is odd, return 0
    if (scalar(@chars) % 2 != 0) {
        return 0;
    }

    # Check if brackets are balanced
    for (my $i = 0; $i < scalar @chars; $i++) {
        # If first character is from closing brackets, return 0
        if (($i == 0) and (($chars[$i] eq ')') or ($chars[$i] eq ']') or ($chars[$i] eq '}'))) {
            return 0;
        }

        if (($chars[$i] eq '(') or ($chars[$i] eq '[') or ($chars[$i] eq '{')) {
            push(@stack, $chars[$i]);
        } else {
            my $pop_char = pop(@stack);

            if (($pop_char ne '(') and ($chars[$i] eq ')') or
                ($pop_char ne '[') and ($chars[$i] eq ']') or
                ($pop_char ne '{') and ($chars[$i] eq '}')) {
                return 0;
            }
        }
    }

    # If stack is not empty after the loop completes, return 0
    if (scalar @stack != 0) {
        return 0;
    }

    return 1;
}

#
# Main starts here
#
my @arr = ('({[]})|', '({[]})', '[]{}', '([])', '([)]', '](){', '([]{})', '{[({}[])]}', '(()(');

foreach my $str (@arr) {
    if (balanced($str)) {
        print "String \'". $str ."\' is balanced.\n";
    } else {
        print "String \'". $str ."\' is NOT balanced.\n";
    }
}