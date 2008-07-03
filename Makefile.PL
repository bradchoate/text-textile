use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'         => 'Text::Textile',
    'VERSION_FROM' => 'lib/Text/Textile.pm',
    ($] >= 5.005 ?
        (ABSTRACT_FROM => 'lib/Text/Textile.pm',
         AUTHOR        => 'Brad Choate <brad@bradchoate.com>') : ()),
);
