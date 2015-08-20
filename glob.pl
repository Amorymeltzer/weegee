#!/usr/bin/env perl

use strict;
use warnings;
use File::Copy;

my @files = <~/Desktop/wg/*>;
my $folder;
my $formatLength = 0;

foreach my $file (@files) {
  chomp $file;
  $folder = substr $file, 31;
  if (!($folder =~ m/.\..*/)) {
    my @nums = split /x/, $folder;
    my $ratio = $nums[0]/$nums[1];
    my $formatRatio = substr $ratio, 0, 5;
    if (!($formatRatio =~ m/.*\..*/)) {
      $formatRatio .= '.';
    }
    $formatLength = length $formatRatio;
    while ($formatLength <= 4) {
      $formatRatio .= 0;
      $formatLength = length $formatRatio;
    }
    my $newTitle = "$formatRatio ($nums[0]x$nums[1])";
    move("$file","/Users/amorymeltzer/Desktop/wg/$newTitle");
  }
}
