#!/usr/bin/env perl

use strict;
use warnings;
#use re 'debug';

my ($hash, $locus, $name);	# store hash, location, name of each file
my @cur;			# current hash and location set

open my $raw, '<', 'matchList.txt' or die $!; # list of hashes and filepaths
open my $output, '>', 'dupes.txt' or die $!;
open my $check, '>', 'manualCheck.txt' or die $!; # some need to be checked manually

while (my $nextword = <$raw>) {
  chomp $nextword;

  $hash = substr $nextword, 0, 32; # steal the sum
  $locus = substr $nextword, 34;   # pilfer the path
  $name = findName($locus);	    # filch the file name

  # indicates we've reaches a new set of files,
  # thus we need to initialize our current var
  undef @cur if ((@cur) && ($cur[0] ne $hash));

  # new set, new reference hash to work with
  if (!@cur) {
    @cur = ($hash,$locus,$name);
  }

  # the workhorse of this endeavor
  else {
    # if both names have text names, print 'em to a file to check manually
    print $check "$cur[1]\n$locus\n\n" if (($cur[2] =~ m/\D+.*\.(?:jpg|gif|png)/i) && ($name =~ m/\D+.*\.(?:jpg|gif|png)/i));
    # just in case two copies have both been filed
    print $check "$cur[1]\n$locus\n\n" if (($cur[1] =~ m/amorymeltzer\/pictures\//i) && ($name =~ m/amorymeltzer\/pictures\//i));


    if (($cur[1] =~ m/amorymeltzer\/pictures\//i) && ($cur[2] =~ m/\D+.*\.(?:jpg|gif|png)/i)) {
      print $output "$locus\n";
      next;
    } elsif (($locus =~ m/amorymeltzer\/pictures\//i) && ($name =~ m/\D+.*\.(?:jpg|gif|png)/i)) {
      print $output "$cur[1]\n";
      @cur = ($hash,$locus,$name);
      next;
    }
    #NOT NEEDED
    elsif (($cur[2] =~ m/\D+.*\.(?:jpg|gif|png)/i) && ($name =~ m/^\d+\.(?:jpg|gif|png)/i))
      # current name contains any non-digits and new name is only digits
      {
	print $output "$locus\n";
	next;
      } elsif (($cur[2] =~ m/^\d+\.(?:jpg|gif|png)/i) && ($name =~ m/\D+.*\.(?:jpg|gif|png)/i))
	# opposite case
	{
	  print $output "$cur[1]\n";
	  @cur = ($hash,$locus,$name);
	  next;
	}
    #NOT NEEDED
    elsif (($cur[2] =~ m/^\d+\.(?:jpg|gif|png)/i) && ($name =~ m/^\d+\.(?:jpg|gif|png)/i))
      # both just have number names
      {
	print $output "$locus\n";
	next;
      } else {
	print $output "$locus\n";
      }
  }
}
close $raw or die $!;
close $output or die $!;
close $check or die $!;

sub findName			# gets the filename out of the filepath
  {
    my @fname = split("/", shift);
    return pop @fname ;
  }
