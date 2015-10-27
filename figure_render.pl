#!/usr/bin/perl
use warnings;
use  strict;
use v5.18;

#######################FIGURE####################
package Figure;
use Data::Dumper;
sub new {
    my $class = shift;
    print Dumper \@_;
    my %args = @_;
    print Dumper \%args;
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

####################TRIANGLE###################
package Rectangle;

use Data::Dumper;

our @ISA = qw (Figure);

sub area {
    my $self = shift;
    my @coordinates = $self->{"coordinates"};
    #print Dumper \@coordinates;

}

1;
###################SQUARE######################
package Square; 

our @ISA = qw(Rectangle);

sub new { 
    my $class =shift; 
    my %args = @_;
    return $class->SUPER::new(color=>$args{"color"} || "Blue");
}
1;
##################CIRCLE#######################
package Circle;

our @ISA = qw(Figure);

sub new {
    my $class = shift;
    my %args = @_;
    return $class->SUPER::new(color => $args{"color"}||"Yelow");
}
1;

package main;
use Data::Dumper;

my @coordinates = (Point->new(x=>1, y=>4),Point->new(x=>5, y=>4),Point->new(x=>5, y=>1),Point->new(x=>1, y=>1));
my $rectangle = Rectangle->new(color => "Red",coordinates => @:coordinates);
print Dumper \$rectangle;
