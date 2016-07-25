use 5.022001;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'GSheet2TSV',
    VERSION_FROM      => 'lib/GSheet2TSV.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {
      'LWP::Simple' => 0
    }, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/GSheet2TSV.pm', # retrieve abstract from module
    AUTHOR            => 'Stephen Wells <wells@cedarnet.org>',
    LICENSE           => 'perl',
);
