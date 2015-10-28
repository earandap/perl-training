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
    my $scala = 3;
    my $a = $coordinates[0]->distance($coordinates[1]);
    my $b = $coordinates[1]->distance($coordinates[2]);
    print color ($self->{"color"});
    for my $x (0.. $b*$scala - 1){
        for my $y (0..$a*$scala - 1){
            print "..";
        }
        print "\n";
    }
    print color("white");
}



1;
###################SQUARE######################
package Square; 

our @ISA = qw(Rectangle);

sub new { 
    my $class =shift; 
    my %args = @_;
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
    my $scala = 3;
    my @coordinates = @{$self->{"coordinates"}};
    my $radio = $coordinates[0]->distance($coordinates[1]);
    my $a = $radio * $scala;
    for my $x(0..($radio * 2 * $scala)){
        for my $y (0..($radio * 2 * $scala )){
            if((($x-$a)**2 + ($y-$a)**2) < ($radio*$scala)**2){
                print color($self->{"color"});
                print "..";
            }else{
                print color("white");
                print "##";
            }
        }
        print "\n";
    }
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
    my $scale = 4;
    my $side = $coordinates[0]->distance($coordinates[1])* $scale; 
    my $heigh = (sqrt 3) / 2 * $side;
    for my $y (0..$heigh-1){
        for my $x (0..$side-1){
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

}        
1;
package main;
use Data::Dumper;

my @coordinates = (Point->new(x=>1, y=>4),Point->new(x=>5, y=>4),Point->new(x=>5, y=>1),Point->new(x=>1, y=>1));
my $rectangle = Rectangle->new(coordinates=>\@coordinates);
say $rectangle->area;
$rectangle->draw;
#print Dumper \$rectangle;
my @coordinates_circle = (Point->new(x=>5, y=> 0),Point->new(x=>5,y=>5));
my $circle = Circle->new(coordinates => \@coordinates_circle);
say $circle->area;
$circle->draw;
#print Dumper \$circle;
my @coordinates_triangle = (Point->new(x=>0, y=>0),Point->new(x=>0,y=>5), Point->new(x=>2,y=>3.4641));
my $triangle = Triangle->new(coordinates=> \@coordinates_triangle);
say $triangle->area;
$triangle->draw
#print Dumper $triangle;


#$rectangle->set_coordinates(@coordinates);
#print Dumper \$rectangle;
#print Dumper @$rectangle->get_coordinates;
