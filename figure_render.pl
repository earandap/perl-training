#!/usr/bin/perl
use warnings;
use  strict;
use v5.18;

#######################FIGURE####################
package Figure;

sub new {
    my $class = shift;
    my %args = @_;
    my $self = bless {}, $class;
    
    #color of figure
    $self->{"color"} = $args{"color"};
    
    #coordenates of figure
    $self->{"coordenates"} = $args{"coordenates"};
    
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

1;

####################TRIANGLE###################
package Rectangle;

our @ISA = qw (Figure);

sub new {
    my $class = shift;
    my %args = @_;
    return  $class->SUPER::new( color => $args{"color"} || "Red" );
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

say "hola mundo!";
   
