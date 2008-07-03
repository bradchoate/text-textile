#!/usr/bin/perl -w

use warnings;
use strict;

use Test::More tests=>1;
use Text::Textile qw(textile);

my $source = '"title":http://www.example.com';
my $dest = textile($source);
my $expected = '<p><a href="http://www.example.com">title</a></p>';

is($dest, $expected);
