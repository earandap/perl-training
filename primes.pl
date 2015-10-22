 #!/usr/bin/perl
 use v5.18; 
  
#read input parameter
my ($MAX) = @ARGV;

my @prime;
my @sieve;
my $i;
my $j;
my $index= 0;

#create sieve of Eratosthenes by default all are prime numbers
for($i=2; $i < $MAX; $i++){
 $sieve[$i] = 1;
}

for($i = 2; $i < $MAX; $i++){
 say $MAX;
 say $i;
 #find next prime
 while($sieve[$i]==0 && $i<$MAX){
  say("no is prime: $i");
  $i++;
 }
 if($i < $MAX){
 #prime found!
 say("found prime!: $i");
 $prime[$index]=$i; 
 #say @prime;
 for($j=2*$i;$j<$MAX; $j+=$i){
  #mark multiples of $j
  $sieve[$j]=0;
 }

 $index++;
}
}


say @sieve;
say @prime;


