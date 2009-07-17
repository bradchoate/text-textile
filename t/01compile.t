#!/usr/bin/perl -Tw

use strict;
use warnings;

use Test::More tests=>1;

BEGIN {
    use_ok('Text::Textile');
}

diag( "Testing Text::Textile $Text::Textile::VERSION under Perl $], $^X" );
