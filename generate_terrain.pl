#!/usr/bin/perl -w
#
# Script to create a 2D terrain of nodes
#
# modified copy of https://github.com/rainbow-src/sensors/tree/master/terrain%20generators

use strict;
use warnings;
use Math::Random;
use Text::CSV_XS;

(@ARGV==3) || die "usage: $0 <terrain_side_size_(m)> <num_of_nodes> <num_of_gateways>\ne.g. $0 100 500 10\n";

my $tx = $ARGV[0];
my $nodes = $ARGV[1];
my $gws = $ARGV[2];

($tx < 1) && die "grid side must be higher than 1 meters!\n";
($nodes < 1) && die "number of nodes must be higher than 1!\n";

my @sensors;
# my @gws;
my %coords;

for(my $i=1; $i<=$nodes; $i++){
	my ($x, $y) = (int(rand($tx*10)), int(rand($tx*10)));
	($x, $y) = ($x/10, $y/10);
	while (exists $coords{$x}{$y}){
		($x, $y) = (int(rand($tx*10)), int(rand($tx*10)));
		($x, $y) = ($x/10, $y/10);
	}
	$coords{$x}{$y} = 1;
	push(@sensors, [$x, $y]);
}
# for(my $i=1; $i<=$gws; $i++){
# 	my ($x, $y) = (int(rand($tx*10)), int(rand($tx*10)));
# 	($x, $y) = ($x/10, $y/10);
# 	while (exists $coords{$x}{$y}){
# 		($x, $y) = (int(rand($tx*10)), int(rand($tx*10)));
# 		($x, $y) = ($x/10, $y/10);
# 	}
# 	$coords{$x}{$y} = 1;
# 	push(@gws, [$x, $y]);
# }
open my $fh, '>', "data.txt" or die $!;
print $fh (join(", ", @$_), "\n") for @sensors;
  

printf "# terrain map [%i x %i]\n", $tx, $tx;
print "# node coords:";
my $n = 1;
foreach my $s (@sensors){
	my ($x, $y) = @$s;
	printf " %s [%.1f %.1f]", $n, $x, $y;
	$n++;
}

open(my $py, "|-", "python kmean.py $gws") or die "Cannot run Python script: $!";

print "\n";
print "# gateway coords:";
my $l = "A";

# my $file = "cluster.txt" or die;
# open(my $data, '<', $file) or die;
# while (my $line = <$data>) {
#     chomp $line;
#     # Split the line and store it
#     # inside the words array
#     my @words = split ",", $line; 
#     printf " %s [%.1f %.1f]", $l, $words[0], $words[1]; 
#     # for (my $i = 0; $i <= 2; $i++){
#     #     print "$words[$i] ";
#     # }
#     $l++;
# }


my @gws;   # 2D array for CSV data
my $file = 'cluster.txt';
open (INFILE, $file);

while (my $linedata = <INFILE>) { 
   push # creates the next (n) slot(s) in an array
       @gws
     , [ split ',',$linedata ] 
       # ^ we're pushing an *array* not just additional elements.
      ; 
}

foreach my $g (@gws){
	my ($x, $y) = @$g;
	printf " %s [%.1f %.1f]", $l, $x, $y;
	$l++;
}
print "\n";

print  "# generated with: $0 ",join(" ",@ARGV),"\n";
printf "# stats: nodes=%i gateways=%i terrain=%.1fm^2 node_sz=%.2fm^2\n", scalar @sensors, scalar @gws, $tx*$tx, 0.1 * 0.1;
