#!/usr/bin/perl -w

use warnings;
use strict;
use Test::More tests=>1;
use Text::Textile qw(textile);

my $source = <<'SOURCE';
@if@, @while@, @for@ and @else@ are some of my favorite keywords. I also like the variable @i@.
SOURCE

my $dest = textile($source);
$dest =~ s/(^\s+|\s+$)//g;

my $expected = <<'EXPECTED';
<p><code>if</code>, <code>while</code>, <code>for</code> and <code>else</code> are some of my favorite keywords. I also like the variable <code>i</code>.</p>
EXPECTED
$expected =~ s/(^\s+|\s+$)//g;

is($dest, $expected);
