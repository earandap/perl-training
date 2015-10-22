 #!/usr/bin/perl
 use v5.18; 
 
#read input parameters
my ($A,$B,$C) = @ARGV;

#check for absent arguments 
$A = ($A)?$A:0;
$B = ($B)?$B:0;
$C = ($C)?$C:0;

#check for if only numbers
for my $parameter ($A,$B,$C) {
  if($parameter !~ /^-?(?:\d+\.?|\.\d)\d*\z/){
   die ("bad input\n");
  }
}

 # using quadratic formula
 if(($B ** 2 - 4 * $A * $C) < 0)
 {  
  die ("no real solutions\n");
 }
  
 my $x1 = (-$B + sqrt($B ** 2 - 4 * $A * $C)) / (2 * $A);
 my $x2 = (-$B - sqrt($B ** 2 - 4 * $A * $C)) / (2 * $A);

 say "$x1 $x2";
 