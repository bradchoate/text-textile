#!/usr/bin/perl -w

use warnings;
use strict;
use Test::More tests=>2;
use Text::Textile qw(textile);

my $source = <<'SOURCE';
**bold** __italic__ *strong* _em_ -del- +ins+ ++big++ --small-- ~sub~
SOURCE

my $tt = new Text::Textile;
my $dest = $tt->format_phrase_modifiers( text => $source );
$dest =~ s/(^\s+|\s+$)//g;

my $expected = <<'EXPECTED';
<b>bold</b> <i>italic</i> <strong>strong</strong> <em>em</em> <del>del</del> <ins>ins</ins> <big>big</big> <small>small</small> <sub>sub</sub>
EXPECTED
$expected =~ s/(^\s+|\s+$)//g;

is($dest, $expected);

my $textile_dest = textile( $source );
$textile_dest =~ s/(^\s+|\s+$)//g;
is($dest, $expected);
