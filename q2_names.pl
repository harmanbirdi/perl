#!/usr/bin/perl

#
# Author      : Harman Birdi
# Date        : Sep 13, 2016
# Description : Program to print out the hash sorted primarily by length of last name (value)
#               with a secondary sort alphabetically by first name (key).
#

use strict;
use warnings FATAL => 'all';
use Data::Dumper qw(Dumper);

my %last_name = (Mary => 'Li', James => 'O\'Day', Thomas => 'Miller',
                 William => 'Garcia', Elizabeth => 'Davis');

foreach my $key (sort {length($last_name{$b}) <=> length($last_name{$a}) or $a cmp $b} (keys %last_name)) {
    print length($last_name{$key}) . " " . $last_name{$key} . ", " . $key . "\n";
}
