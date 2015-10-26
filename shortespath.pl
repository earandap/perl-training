#!/usr/bin/perl:w

use v5.18;
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(min max);

my %map;
sub shortest_path {
	my ($start,$end,$steps) = @_;

	if($start eq $end){
		return $steps;
	}
	if(!exists $map{$start}){
		return -1;
	}
	my @distances;
	foreach my $node (@{$map{$start}}){
		my $current = shortest_path($node,$end,$steps+1);
		push @distances,$current;
	}
	@distances = grep {$_ != -1} @distances;
	my @sorted_distances = sort @distances;
	foreach my $dis (@sorted_distances){
		if($dis != -1){
			return $dis;
		}
	}
	return -1;
		
}

if(!$ARGV[0]){
	die ("bad input\n");
}
open("points","<:utf8", $ARGV[0]) || die "Can't open $ARGV[0] file: $!\n";
my $input = <points>;
while(<points>){
	chomp $_;
        my @nodes = split;
	if(!exists $map{$nodes[0]}){
		@map{$nodes[0]}= [];
	}
	push @map{$nodes[0]},$nodes[1];
}
my @point = split (" ",$input);
print shortest_path($point[0],$point[1],0)."\n";
