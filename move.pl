#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;

use File::Copy;
use Image::Size;
use File::Path;

if (@ARGV != 1) {
  print "Must provide directory with only images in it\n";
  exit 1;
}

print "Moving duplicates to trash\n";
open my $raw, '<', 'dupes.txt' or die $!;

while (my $nextword = <$raw>) {
  chomp $nextword;
  move("$nextword",'/Users/Amory/.Trash/');
}
close $raw or die $!;

print "Moving files based on size\n";
# Get list of files from directory
# Imperfect
opendir my $dir, "$ARGV[0]" or die $1;
my @files = grep {-f "$ARGV[0]/$_" } readdir $dir; # No dots
closedir $dir or die $1;

foreach my $file (0..scalar @files-1) {
  next if $files[$file] =~ /\.DS_Store/; # pesky
  my ($hRes, $vRes) = imgsize($ARGV[0].$files[$file]);

  my $dime = sprintf "%.3f", $hRes/$vRes;
  my $newDir = $ARGV[0].$dime."-($hRes".'x'."$vRes)";
  if (!-e $newDir || !-d $newDir) { # Doesn't exist or not a directory
    mkpath($newDir);
  }
  move($ARGV[0].$files[$file],$newDir);
}
