#!/usr/bin/env perl

use warnings;
use strict;
use 5.20.0;

open(my $py, "|-", "python kmean.py") or die "Cannot run Python script: $!";



