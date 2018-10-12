#!/usr/bin/env perl

use strict;
use warnings;
use File::Copy;

open my $raw, '<', 'dupes.txt' or die $!;

while (my $nextword = <$raw>) {
  chomp $nextword;
  move("$nextword",'/Users/Amory/.Trash/');
}
close $raw or die $!;
