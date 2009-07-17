#!/usr/bin/perl -Tw

use warnings;
use strict;
use Test::More tests => 2;
use Text::Textile;

{
    my $tt = Text::Textile->new( disable_encode_entities => 1 );

    my $source = <<'SOURCE';
start paragraph

another paragraph

* list of things with "urls":http://www.jerakeen.org in
* more things in the list

a http://bare.url.here. and an email@address.com

>>> No encode_entities here
<<< and there
&&& and here too

SOURCE

    my $dest = $tt->process($source);
    $dest =~ s/(^\s+|\s+$)//g;

    my $expected = <<'EXPECTED';
<p>start paragraph</p>

<p>another paragraph</p>

<ul>
<li>list of things with <a href="http://www.jerakeen.org">urls</a> in</li>
<li>more things in the list</li>
</ul>

<p>a http://bare.url.here. and an email@address.com</p>

<p>>>> No encode_entities here<br />
<<< and there<br />
&&& and here too</p>
EXPECTED
    $expected =~ s/(^\s+|\s+$)//g;

    is( $dest, $expected );
}

{
    my $tt = Text::Textile->new( disable_encode_entities => 0 );

    my $source = <<'SOURCE';
start paragraph

another paragraph

* list of things with "urls":http://www.jerakeen.org in
* more things in the list

a http://bare.url.here. and an email@address.com

>>> encode_entities here
<<< and there
&&& and here too

SOURCE

    my $dest = $tt->process($source);
    $dest =~ s/(^\s+|\s+$)//g;

    my $expected = <<'EXPECTED';
<p>start paragraph</p>

<p>another paragraph</p>

<ul>
<li>list of things with <a href="http://www.jerakeen.org">urls</a> in</li>
<li>more things in the list</li>
</ul>

<p>a http://bare.url.here. and an email@address.com</p>

<p>&gt;&gt;&gt; encode_entities here<br />
&lt;&lt;&lt; and there<br />
&amp;&amp;&amp; and here too</p>
EXPECTED
    $expected =~ s/(^\s+|\s+$)//g;

    is( $dest, $expected );
}
