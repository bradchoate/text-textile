#!/usr/bin/perl -Tw

use warnings;
use strict;
use Test::More tests=>2;
use Text::Textile qw(textile);


#--------------------------------------------------------------------------------
# helpers
#--------------------------------------------------------------------------------
# call textile & trim leading/trailing whitespace from each line
sub flat_textile {
	local $_ = textile(shift);
	s/(^\s+|\s+$)//gs;
	$_;
	}

# take our readable 'expected' HTML & flatten it to match textile() output
sub flat_want {
	local ($_) = @_;
	s~^\s*~~mg;
	s~\n~~g;
	$_;
	}


#--------------------------------------------------------------------------------
# tests
#--------------------------------------------------------------------------------
diag('NOTE - "empty cell" deviates from http://txstyle.org/doc/15/tables');
diag('NOTE - "tableclass" deviates from http://txstyle.org/doc/15/tables');

my $source = q{
| A | simple | table | row |
| And | another | table | row |
| With an | | empty | cell |
};
my $expected = q{
<table>
		<tr>
			<td>A</td>
			<td>simple</td>
			<td>table</td>
			<td>row</td>
		</tr>
		<tr>
			<td>And</td>
			<td>another</td>
			<td>table</td>
			<td>row</td>
		</tr>
		<tr>
			<td colspan="2">With an</td>
			<td>empty</td>
			<td>cell</td>
		</tr>
</table>
};


is(flat_textile($source), flat_want($expected), 'empty cell');



$source = q{
|_. First Header |_. Second Header |
| Content Cell | Content Cell |
};
$expected = q{
<table>
		<tr>
			<th>First Header</th>
			<th>Second Header</th>
		</tr>
		<tr>
			<td>Content Cell</td>
			<td>Content Cell</td>
		</tr>
</table>
};

is(flat_textile($source), flat_want($expected), 'Header row');



$source = q{
table(tableclass).
|a|classy|table|
|a|classy|table|
};
$expected = q{
<table class="tableclass" cellspacing="0">
		<tr>
			<td>a</td>
			<td>classy</td>
			<td>table</td>
		</tr>
		<tr>
			<td>a</td>
			<td>classy</td>
			<td>table</td>
		</tr>
</table>
};

is(flat_textile($source), flat_want($expected), 'tableclass');


$source = q{
|^.
|_. First Header |_. Second Header |
|-.
| Content Cell | Content Cell |
| Content Cell | Content Cell |
};
$expected = q{
<table>
	<thead>
		<tr>
			<th>First Header</th>
			<th>Second Header</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Content Cell</td>
			<td>Content Cell</td>
		</tr>
		<tr>
			<td>Content Cell</td>
			<td>Content Cell</td>
		</tr>
	</tbody>
</table>
};

is(flat_textile($source), flat_want($expected), 'HTML5 "thead" support');









