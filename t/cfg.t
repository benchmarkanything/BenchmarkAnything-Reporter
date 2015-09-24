#! /usr/bin/perl

use strict;
use warnings;
use Test::More 0.88;

require BenchmarkAnything::Reporter;

my $cfg1 = BenchmarkAnything::Reporter->new;
is($cfg1->{config}{benchmarkanything}{storage}{backend}{sql}{dsn}, "dbi:SQLite:t/benchmarkanything.sqlite", "cfg 1");

$ENV{BENCHMARKANYTHING_CONFIGFILE} = "t/benchmarkanything-2.cfg";
my $cfg2 = BenchmarkAnything::Reporter->new;
is($cfg2->{config}{benchmarkanything}{storage}{backend}{sql}{dsn}, "dbi:SQLite:t/benchmarkanything-alternative.sqlite", "cfg 2");

# Finish
done_testing;
