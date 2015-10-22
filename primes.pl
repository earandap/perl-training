 #!/usr/bin/perl
 use v5.18; 
  
#read input parameter
my ($MAX) = @ARGV;

#validate the input
if($MAX !~ /^\d/ || $MAX > 1000000){
   die ("bad input\n");
}
   
#declare vars
my (@sieve,$i, $j, $count);
$i = $j = $count= 0;

#read begin time
my $start = time();

#create sieve of Eratosthenes by default all are prime numbers
for($i=2; $i < $MAX; $i++){
 $sieve[$i] = 1;
}

#processing numbers
for($i = 2; $i < $MAX; $i++){
 
 #find next prime
 while($sieve[$i]==0 && $i<$MAX){  
  $i++;
 }
 
 if($i < $MAX){
  #found prime!
  print "$i ";
    
  for($j=2*$i;$j<$MAX; $j+=$i){
   #mark multiples of $j
   $sieve[$j]=0;
  }
  $count++;
 }
}

#read end time
my $end = time();

print "\n";

say("done! found $count primes in " . ($end - $start). " seconds");