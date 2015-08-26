#!/usr/bin/env perl

use strict;
use warnings;

open my $raw, '<', 'matchList.txt' or die $!;
open my $output, '>', 'dupes.txt' or die $!;

while (my $nextword = <$raw>) {
  chomp $nextword;
  #    $nextword =~ m/^(\d+)\w*/i;
  #    my $word = $1.substr $nextword, length($1)+43;
  my $word = substr $nextword, 43;
  print $output "$word\n";
}
close $raw or die $!;
close $output or die $!;
