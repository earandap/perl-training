#!/usr/bin/perl
use warnings;
use  strict;
use v5.18;

#######################FIGURE####################
package Figure;
use Data::Dumper;
sub new {
    my $class = shift;
    my %args =  @_;
    my $self = bless {}, $class;
    
    #color of figure
    $self->{"color"} = $args{"color"};
    
    #coordinates of figure
    $self->{"coordinates"} = $args{"coordinates"};
    
    return $self;
}
# get color
sub get_color {
    return shift->{"color"};
}

sub get_coordinates {
    return shift->{"coordinates"};
}
sub set_coordinates {
    my $self = shift;
    my @coordinates = shift;
    $self->{"coordinates"} = @coordinates;
}


#default area method
sub area{
    print "area\n";
}

#default draw method
sub draw{
    print "draw\n"
}

1;
####################POINT######################
package Point;
sub new {
    my $class = shift;
    my %args = @_;
    return bless {x => $args{"x"},y => $args{"y"}},$class;
}
sub get_x {
    return shift->{"x"};
}
sub get_y {
    return shift->{"y"};
}

sub distance {
    
    my $self = shift;
    my ( $point ) = @_;
    
    return sqrt (($self->{"x"} - $point->{"x"})**2 + ($self->{"y"}-$point->{"y"})**2); 
}
1;

####################RECTANGLE#################
package Rectangle;
use Term::ANSIColor;
use Data::Dumper;

our @ISA = qw (Figure);
sub new {
    my $class = shift;
    my %args = @_;
    if(scalar @{$args{"coordinates"}} != 4){
        die("A rectangle must have 4 coordinates points \n");
    }
    #TODO is a rectangle?
    return $class->SUPER::new(color=>$args{"color"}||"red",coordinates => $args{"coordinates"});
}

sub area {
    my $self = shift;
    my @coordinates = @{$self->{"coordinates"}};
    return $coordinates[0]->distance($coordinates[1])*$coordinates[1]->distance($coordinates[2]);
}

sub draw {
    my $self = shift;
    my @coordinates = @{$self->{"coordinates"}};
    my $scale = 1;
    my $a = $coordinates[0]->distance($coordinates[1]);
    my $b = $coordinates[1]->distance($coordinates[2]);
    print color ($self->{"color"});
    for (my $x = 0; $x < $b*$scale; $x+=0.2){
       for(my $y = 0 ; $y < $a * $scale; $y+=0.2){
            print "..";
        }
        print "\n";
    }
    print color('reset');}



1;
###################SQUARE######################
package Square; 

our @ISA = qw(Rectangle);

sub new { 
    my $class =shift; 
    my %args = @_;
    #TODO is a square?
    return $class->SUPER::new(color=>$args{"color"} || "Blue", coordinates => $args{"coordinates"});
}

1;
##################CIRCLE#######################
package Circle;
our @ISA = qw(Figure);
use Math::Trig ':pi';
use Term::ANSIColor;
sub new {
    my $class = shift;
    my %args = @_;
    if(scalar @{$args{"coordinates"}} != 2) {
        die("A circle must have 2 coordinates points \n");
    }
    return $class->SUPER::new(color => $args{"color"}||"yellow", coordinates => $args{"coordinates"});
}

sub area {
    my $self = shift;
    my @coordinates = @{$self->{"coordinates"}};
    return pi/4 * ($coordinates[0]->distance($coordinates[1])*2)**2;
}
sub draw {
    my $self = shift;
    my $scale = 1;
    my @coordinates = @{$self->{"coordinates"}};
    my $radio = $coordinates[0]->distance($coordinates[1]);
    my $a = $radio * $scale;
    for (my $x = 0; $x <= $radio * 2; $x+=0.1){ 
	 for (my $y = 0; $y <= $radio * 2; $y+= 0.1){
            if((($x-$a)**2 + ($y-$a)**2) < ($radio*$scale)**2){
                print color($self->{"color"});
                print "..";
            }else{
                print color("white");
                print "##";
            }
        }
        print "\n";
    }
    print color('reset');
}
1;
###################TRAINGLE####################
package Triangle;
use Term::ANSIColor;
our @ISA = qw(Figure);

sub new {
    my $class = shift;
    my %args = @_;
    if(scalar @{$args{"coordinates"}} != 3) {
        die("A triangle  must have 3 coordinates points \n");
    }
    #TODO is a equilateral triangle?;
    return $class->SUPER::new(color => $args{"color"}||"white", coordinates => $args{"coordinates"});
}

sub area {
    my $self = shift;
    my @coordinates = @{$self->{"coordinates"}};
    return ((sqrt 3) / 4) * $coordinates[0]->distance($coordinates[2])**2;
}

sub draw {
    my $self = shift;
    my @coordinates = @{$self->{"coordinates"}};
    my $scale = 1;
    my $side = $coordinates[0]->distance($coordinates[1])* $scale; 
    my $height = (sqrt 3) / 2 * $side;
    for (my $y = 0; $y < $height;$y+=0.2){ 
        for (my $x  = 0; $x < $side; $x+=0.2 ){
            if (($side/2 - $y * (sqrt 3) / 3) <= $x && $x <= ($side/2 + $y * (sqrt 3) /3)){
                print color($self->{"color"});
                print "..";
            }
            else {
                print color("white");
                print "  ";
            }
        }
        print "\n";
    }
    print color('reset');
}        
1;
package main;
use Data::Dumper;
use DBI;
my $database = "figures";
my $hostname = "localhost";
my $port = 3306
my $dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
my $dbh = DBI->connect($dsn,"root","") or die "Unable to connect: $DBI::errstr\n";

sub read_coordinates {
   my @coordinates;
   foreach my $coordinate (@_){
        my ($x, $y) = split ',', $coordinate;
        push @coordinates, Point->new(x => $x, y => $y);
   }
   return @coordinates;
}

sub persist {
     my $type = shift;
     #TODO begin transaction
     $dbh->do("INSERT INTO figure (figure_type) VALUES (?)", undef, $type);
     my $last_id = $dbh->last_insert_id(undef, undef, "figure", "figure_id");
     foreach my  $point (@_) {
         my @params = ($point->{"x"},$point->{"y"},$last_id);
         $dbh->do("INSERT INTO point (point_x, point_y,figure_id) VALUES (?,?,?)", undef,@params);
      }
     #TODO commit transaction
}
sub print_figure_by_type {
    my $type = shift;
    my $query = "SELECT * FROM figure INNER JOIN point ON point.figure_id = figure.figure_id WHERE figure_type = ?";
    my $sth = $dbh->prepare($query);
    $sth->execute($type);
    my $last_id = -1;
    my $p = 1;
    say "######################## FIGURES LIST BY TYPE: $type ##########################";
    while(my @row = $sth->fetchrow_array){
        my $id = shift @row;
        if($last_id == $id){
           say "P$p x:".$row[2]. " y:".$row[3];
           $p++;
        }
        else{
            $p = 1;
            $last_id= $id;
            say $id . " " . $row[0];
            say "P$p x:".$row[2]. " y:".$row[3];
            $p++;
        }
    }
    say "################################################################################";

}

open("COMMANDS","<:utf8", $ARGV[0]) || die "Can't open $ARGV[0] file: $!\n";
while(<COMMANDS>){
    my @line = split;
    my $command = shift @line;
    my $type = shift @line;
    if($command eq "create" ){
        if($type =~ /Rectangle|Triangle|Square|Circle/){
             my @coordinates = read_coordinates(@line);
            #TODO catch exception here
            #my $figure = eval{$type->new(coordinates => \@coordinates)} or do {
            #    print STDERR $@;
            #    next;
            #} 
            #print Dumper \$figure;
            my $figure = $type->new(coordinates => \@coordinates);
            $figure->draw;
            my $area = $figure->area;
            say "The area of the $type is $area";
            persist($type,@coordinates);
        }else{
            print STDERR "The figure type: {$type} not exist. \n";
        }
    }elsif($command eq "list" ){
        print print_figure_by_type($type);
            #for my @f @figures){
            #    print "ID: " . $f[0] . "| TYPE: " . $f[1] . "\n";
            #}
    }    
    else{
        print STDERR "The command {$command} not exist.\n";
    }
}

$dbh->disconnect;
