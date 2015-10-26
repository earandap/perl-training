#!/usr/bin/perl:w

use v5.18;
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(min max);

my %map;
sub shortest_path {
	my ($start,$end,$steps,%visit_nodes) = @_;
    #print "start: $start end: $end steps: $steps\n";
    #print Dumper \%visit_nodes;
	if($start eq $end){
		return $steps;
	}
	if(!exists $map{$start}){
		return -1;
	}
	my @distances;
    
    foreach my $node (@{$map{$start}}){
        if(!exists $visit_nodes{$node} || $visit_nodes{$node} > ($steps+1)){
            my $current = shortest_path($node,$end,$steps+1,%visit_nodes);
            $visit_nodes{$node} = $current;
            push @distances,$current;
            #print Dumper \%visit_nodes;
        }
		
    }
	@distances = grep {$_ > 0 } @distances;
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
#print Dumper \%map;
my @point = split (" ",$input);
my %visit_nodes;
$visit_nodes{$point[0]} = 0;
print shortest_path($point[0],$point[1],0,%visit_nodes)."\n";
