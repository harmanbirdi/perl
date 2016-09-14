#!/usr/bin/perl

#
# Author      : Harman Birdi
# Date        : Sep 13, 2016
# Description : Program to preprocess JSON script to remove single line
#               C-style comments from it.
#

use strict;
use warnings FATAL => 'all';

#
# This subroutine splits the original string into multiple lines and
# processes them line by line to check if it contains any // style comment
# It returns the lines without any comments. Any lines that were complete
# comments are replaced by an empty line.
#
sub decommentify {
    my @inlines = split('\n', $_[0]);
    my @outlines = ();

    foreach my $line (@inlines) {

        $line =~ s/(\/)\1+/\/\//g; # First collapse all 2+ occurences of // into one //

        if ($line =~ /^(\w)*\/\/.*/) { # Remove line starting with // or optional whitespace before comment
            push(@outlines, '');
        } elsif ($line =~ /(.*)\/\/.*/) { # Remove lines containing comment //, but keeping the rest
            push(@outlines, $1);
        } elsif ($line =~ /[^\/].*/) { # Keep entire line if not // in it
            push(@outlines, $line);
        }
    }

    return join("\n", @outlines);
}

my $str = <<'EOSTR';
// this is a comment
/////// this is a comment too
{ // another comment
/////////////
   true, "foo", // 3rd comment
   "http://www.ariba.com" // comment after URL
   "http://www.yahoo.com"// no space between text and comment after URL
   "https://www.google.com"//no space between text and comment after URL
   "https://www.google.com?ex=1" //no space between text and comment after URL
// This is a test http://www.pulse.com
   "more than 2 slashes" ///// more than 2 slash comment
}
EOSTR

print "------------\n";
print "INPUT STRING\n";
print "------------\n";
print $str . "\n";

print "-------------\n";
print "OUTPUT STRING\n";
print "-------------\n";
print decommentify($str);
print "\n\n";