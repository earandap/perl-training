#!/usr/bin/perl
use v5.18;

my %words= (
    zero => 0,
    one => 1,
    two => 2,
    three => 3,
    four => 4,
    five => 5,
    six => 6,
    seven => 7,
    eight => 8,
    nine => 9,
    ten => 10,
    eleven => 11,
    twelve => 12,
    thirteen => 13,
    fourteen => 14,
    fifteen => 15,
    sixteen => 16,
    seventeen => 17,
    eighteen => 18,
    nineteen => 19,
    twenty => 20,
    thirty => 30,
    fourty => 40,
    fifty=> 50,
    sixty => 60,
    seventy => 70,
    eighty => 80,
    ninety => 90
);

my %multiply = (
    hundred => 100,
    thousand => 1000,
    milloon => 1000000
);

sub words2num {
   my $result = 0;
   my $tmp = 0;
   my @parts = split(" ",$_);
   my $last_multiplier = 1;
   my $multiplier = 1;
   foreach my $w (@parts){
      $multiplier = $multiply{$w} || 1;   
      if($multiplier > $last_multiplier){
        $result = ($result +$tmp) * $multiplier;
        $tmp = 0;
      }
      else {
        $tmp*=$multiplier;
      }
      if($multiplier != 1){
        $last_multiplier = $multiplier;
        }
     $tmp += $words{$w} || 0;
    }
    return $result + $tmp;
}
my %output;
open(numbers,"<:utf8", "numbers.in") || die "Can't open numbers.in file: $!\n";

while(<numbers>)
{
	chomp $_;
	$output{$_} = words2num($_);
}

foreach(sort {$output{$b}<=>$output{$a}} keys %output){
	say $_;

}
