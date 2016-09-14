#!/usr/bin/perl

#
# Author      : Harman Birdi
# Date        : Sep 13, 2016
# Description : Program to take a string from command line and draw a histogram
#               for it. If whitespace is to be included in the string, it must
#               be quoted by matching single or double quotes.
#

use strict;
use warnings FATAL => 'all';

#
# Subroutine to tokenize each character of the string.
#
# Input  - One argument that is a string of characters.
# Output - Hash with value as count of each character as key.
#
sub tokenize {
    my $param = $_[0];
    my @chars = split('', $param);
    my %hash;

    foreach my $char (@chars) {
        if (exists $hash{$char}) {
            $hash{$char} += 1;
        } else {
            $hash{$char} = 1;
        }
    }

    return %hash;
}

#
# Subroutine to draw a histogram given a hash. This function will
# print the key, followed by n number of # characters, where n
# is the value stored for the key in the hash as a number.
#
sub draw_histogram {
    my (%hash) = @_;

    foreach my $key (sort {$hash{$b} cmp $hash{$a}} (keys %hash)) {
        print $key .  " : ";
        print '#' x $hash{$key} . "\n";
    }
}

#
# Main starts here
#
if (!defined $ARGV[0] or length($ARGV[0]) == 0) {
    my $msg = "ERROR: Please provide a command line string for histogram. If string includes whitespace,\n";
    $msg .= "       enclose it within single or double-quotes";
    die $msg;
} else {
    my %map = tokenize($ARGV[0]);

    draw_histogram(%map);
    exit 0;
}
