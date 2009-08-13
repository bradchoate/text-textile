require 5.006001;

use strict;
use warnings;

use ExtUtils::MakeMaker;

my %parms = (
    NAME          => 'Text::Textile',
    AUTHOR        => 'Brad Choate <brad@bradchoate.com>',
    VERSION_FROM  => 'lib/Text/Textile.pm',
    ABSTRACT_FROM => 'lib/Text/Textile.pm',
    EXE_FILES     => [qw(bin/textile)],
    PREREQ_PM => {
        'Test::Harness' => 2.50, # Something reasonably newish
        'Exporter'      => 0,
        'Test::More'    => 0,
    },
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean         => { FILES => 'Text-Textile-*' },
);

if ( $ExtUtils::MakeMaker::VERSION =~ /^\d\.\d\d$/ and $ExtUtils::MakeMaker::VERSION > 6.30 ) {
    $parms{LICENSE} = 'perl';
}

if ( $ExtUtils::MakeMaker::VERSION ge '6.46' ) {
    $parms{META_MERGE} = {
        resources => {
            bugtracker => 'http://github.com/bradchoate/text-textile/issues',
            repository => 'http://github.com/bradchoate/text-textile/tree/master',
        }
    };
}

WriteMakefile( %parms );


sub MY::postamble {
    my $file_next_filename = qx(perldoc -l File::Next);
    my $postamble = <<'MAKE_FRAG';
.PHONY: tags critic

tags:
	ctags -f tags --recurse --totals \
		--exclude=blib \
		--exclude=.svn \
		--exclude='*~' \
		--exclude='Text-Textile-*' \
		--languages=Perl --langmap=Perl:+.t \

critic:
	perlcritic -1 -profile perlcriticrc -q lib/Text/Textile.pm t/*.t

cover:
	cover -delete
	HARNESS_PERL_SWITCHES=-MDevel::Cover make test
	cover

MAKE_FRAG

}
