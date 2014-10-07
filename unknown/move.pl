#!/usr/bin/env perl

use strict;
use warnings;
use File::Copy;

open(my $raw, '<', "tmp.txt");

while (my $nextword = <$raw>)
{
    chomp $nextword;
    move("$nextword","/Users/amorymeltzer/.Trash/");
}
