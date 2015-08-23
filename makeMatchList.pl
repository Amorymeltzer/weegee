#!/usr/bin/env perl

use strict;
use warnings;


my $file = 'sha.txt';
my $word = '1';
my $count = '0';

open my $raw, '<', $file or die $!;
open my $output, '>', 'matchList.txt' or die $!;

while (my $nextword = <$raw>)
{
    chomp $nextword;
    my $nextOut = substr $nextword, 0, 40;
    my $wordOut = substr $word, 0, 40;
    if (($nextOut eq $wordOut) and !($nextword =~ m/\.DS_/io))
    {
	$count++;
#	print $output "$count\t$word\n$count\t$nextword\n";
	print $output "$word\n" if $count == 1;
	print $output "$nextword\n";
    }
    else
    {
	$count = '0';
    }
    $word = $nextword;
}
close $raw or die $!;
close $output or die $!;
