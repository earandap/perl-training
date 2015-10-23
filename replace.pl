#!/usr/bin/perl
use v5.18; 
  
#ask the string
say("Please, enter 1 line of text:");

#read the string
my $string = <STDIN>;

#ask match and replace
say("Please, enter space separated strings to match and replace (one pair per line).\nEmpty line will interrupt input and start execution:");

#read the match and replace
my $match_replace = <STDIN>;
my %input;

while($match_replace ne "\n"){ 
 #get match and replace
 my @line= split(" ", $match_replace);

#validating input line}
if(0+@line != 2){
    die("bad input\n");
}

 #store match and replace
 $input{$line[0]} = $line[1];
  
 #read next match and replace
 $match_replace = <STDIN>;
}

my $regexp = join "|", keys %input;
$regexp = qr/$regexp/;
$string =~ s/($regexp)/$input{$1}/g;

say ($string);
