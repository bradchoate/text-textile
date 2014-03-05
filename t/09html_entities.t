#!/usr/bin/perl -Tw

use warnings;
use strict;
use Test::More tests=>3;
use Text::Textile qw(textile);

my $source = <<'SOURCE';
&oslash;
SOURCE

my $dest = textile($source);
$dest =~ s/(^\s+|\s+$)//g;

my $expected = <<'EXPECTED';
<p>&oslash;</p>
EXPECTED
$expected =~ s/(^\s+|\s+$)//g;

is($dest, $expected, 'Preserve lowercase html entity?');

$source = <<'SOURCE';
&Oslash;
SOURCE

$dest = textile($source);
$dest =~ s/(^\s+|\s+$)//g;

$expected = <<'EXPECTED';
<p>&Oslash;</p>
EXPECTED
$expected =~ s/(^\s+|\s+$)//g;

is($dest, $expected, 'Preserve mixed-case html entity');

$source = <<'SOURCE';
&frac14;
SOURCE

$dest = textile($source);
$dest =~ s/(^\s+|\s+$)//g;

$expected = <<'EXPECTED';
<p>&frac14;</p>
EXPECTED
$expected =~ s/(^\s+|\s+$)//g;

is($dest, $expected, 'Preserve html entity with number');
