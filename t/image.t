#!/usr/bin/perl -w

use warnings;
use strict;
use Test::More tests=>1;
use Text::Textile qw(textile);

my $source = <<'SOURCE';
this is an !/image/1853561/display(Image)! yay
SOURCE

my $dest = textile($source);
$dest =~ s/(^\s+|\s+$)//g;

my $expected = <<'EXPECTED';
<p>this is an <img src="/image/1853561/display" alt="Image" /> yay</p>
EXPECTED
$expected =~ s/(^\s+|\s+$)//g;

is($dest, $expected);
