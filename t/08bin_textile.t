# Test bin/textile script
use warnings;
use strict;
use Test::More tests=>5;
use File::Temp qw/ tempfile /;

# textile executable to use for the test
my $Textile_Exe = "blib/script/textile";

my $in = "_Hi_ there";
my $expect_out = "<p><em>Hi</em> there</p>\n";
my $title = "My <blink>1337</blink> page";
my $fullpage_expect_out
= "<html>\n<head>\n</head>\n<body>\n$expect_out</body>\n</html>\n";
my $title_expect_out
= "<html>\n<head>\n<title>$title</title>\n</head>\n<body>\n$expect_out</body>\n</html>\n";
textile_is($in, $expect_out, "Simple textile run");
textile_is($in, $fullpage_expect_out, "textile -fullpage", "-fullpage");
textile_is($in, $title_expect_out, "textile -title", qq{-title "$title"});

# Bigger test (stolen from t/05combined.t)
my $source = <<SOURCE;
start paragraph

another paragraph

* list of things with "urls":http://www.jerakeen.org in
* more things in the list

a http://bare.url.here. and an email\@address.com

SOURCE

my $expected = <<EXPECTED;
<p>start paragraph</p>

<p>another paragraph</p>

<ul>
<li>list of things with <a href="http://www.jerakeen.org">urls</a> in</li>
<li>more things in the list</li>
</ul>

<p>a http://bare.url.here. and an email\@address.com</p>
EXPECTED

textile_is($source, $expected, "bigger test");

# Test with outfile (File::Temp will pick a name and add it to -outfile)
textile_is($in, $expect_out, "textile -outfile", "-outfile");

exit;


sub textile_is {
    my ($source, $expected, $name, $opts) = @_;
    $opts = "" unless defined $opts;
    # Make a file with input text. Always delete when program exits
    my ($fh, $filename) = tempfile(undef, UNLINK => 1);
    print $fh $source;
    close $fh;

    my $textile_out;
    if ($opts =~ /-outfile\b/) {
	# (undef, $filename) = tempfile($template, OPEN => 0);
	# File::Temp REALLY doesn't like not opening the temp file
	# (E.g., won't let you use UNLINK=>1)
	# So open it, close it, then let textile write to it.
	my ($out_fh, $out_filename) = tempfile(undef, UNLINK => 1);
	close $out_fh;
	# Give textile the new filename
	$opts =~ s/-outfile\b/-outfile $out_filename/; 
	system "$^X $Textile_Exe $opts $filename"
	    and BAIL_OUT("textile executable broke during '$name' test");
	# Get the textile results
	open my $outin_fh, "<", $out_filename;
	$textile_out = join "", <$outin_fh>;
	close $outin_fh
    }
    else {
	# Run textile
	$textile_out = `$^X $Textile_Exe $opts $filename`;
	BAIL_OUT("textile executable broke during '$name' test")
	    if $? || !defined $textile_out;
    }

    # compare w/ expected
    is($textile_out, $expected, $name);
}
