#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

my %code_test = (
#   Test   => [String,expected result]
    'xhtml' => [ 
            q{bc.. <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="de" xml:lang="de">
<script src="/test/test.js" type="text/javascript"></script>
<head>
<title>Test</title>},
            q{<pre><code>&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;!DOCTYPE html PUBLIC &quot;-//W3C//DTD XHTML 1.0 Transitional//EN&quot; &quot;http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd&quot;&gt;
&lt;html xmlns=&quot;http://www.w3.org/1999/xhtml&quot; dir=&quot;ltr&quot; lang=&quot;de&quot; xml:lang=&quot;de&quot;&gt;
&lt;script src=&quot;/test/test.js&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;
&lt;head&gt;
&lt;title&gt;Test&lt;/title&gt;</code></pre>}
    ],
    'xml_declaration' => [ 
            q{bc. <?xml version="1.0" encoding="UTF-8"?>},
            q{<pre><code>&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</code></pre>}
    ],
    'script_element' => [ 
            q{bc. <script src="/test/test.js" type="text/javascript"></script>},
            q{<pre><code>&lt;script src=&quot;/test/test.js&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</code></pre>}
    ]
);

my ($got,$expected);


diag('Starting tests for bc');

###
require_ok( 'Text::Textile' );
use Text::Textile;
#

###
my $textile = Text::Textile->new;
$expected = $code_test{'xhtml'}->[1];
$got = $textile->process($code_test{'xhtml'}->[0]);
ok($got eq $expected, 'Multiline with XHTML');

###
$textile = Text::Textile->new;
$expected = $code_test{'xml_declaration'}->[1];
$got = $textile->process($code_test{'xml_declaration'}->[0]);
ok($got eq $expected, 'XML declaration');

###
$textile = Text::Textile->new;
$expected = $code_test{'script_element'}->[1];
$got = $textile->process($code_test{'script_element'}->[0]);
ok($got eq $expected, 'JS script element');

###
done_testing();

1;