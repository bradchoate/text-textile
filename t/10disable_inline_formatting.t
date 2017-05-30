#!/usr/bin/perl -Tw

use warnings;
use strict;
use Test::More tests => 1;
use Text::Textile;

{
    my $tt = Text::Textile->new( disable_inline_formatting => 1 );
    warn $tt->{disable_inline_formatting};

    my $source = <<'SOURCE';
start *paragraph*

another ~paragraph~

* list of things with "urls":http://www.jerakeen.org in
* more things in the list

a http://bare.url.here. and an email@address.com

SOURCE

    my $dest = $tt->process($source);
    $dest =~ s/(^\s+|\s+$)//g;

    my $expected = <<'EXPECTED';
<p>start *paragraph*</p>

<p>another ~paragraph~</p>

<ul>
<li>list of things with <a href="http://www.jerakeen.org">urls</a> in</li>
<li>more things in the list</li>
</ul>

<p>a http://bare.url.here. and an email@address.com</p>

EXPECTED
    $expected =~ s/(^\s+|\s+$)//g;

    is( $dest, $expected );
}
