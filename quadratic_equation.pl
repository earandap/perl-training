 #!/usr/bin/perl
 use v5.18; 
 
#read input parameters
my ($A,$B,$C) = @ARGV;

#testing for absent arguments 
$A = ($A)?$A:0;
$B = ($B)?$B:0;
$C = ($C)?$C:0;

 # using quadratic formula
 my $x1 = (-$B + sqrt($B ** 2 - 4 * $A * $C)) / (2 * $A);
 my $x2 = (-$B - sqrt($B ** 2 - 4 * $A * $C)) / (2 * $A);

 say $x1;
 say $x2;