use strict;use warnings;
use Module::Build;

my $builder = Module::Build->new(
    sign              => 1,
    module_name       => 'WWW::OReillyMedia::Store',
    license           => 'perl',
    dist_author       => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    dist_version_from => 'lib/WWW/OReillyMedia/Store.pm',
    add_to_cleanup    => [ 'WWW-OReillyMedia-Store-*' ],    
    build_requires    => {
        'Test::More'     => 0,
        'Readonly'       => 0,
        'HTTP::Request'  => '1.40',
        'LWP::UserAgent' => '2.33',
    },
);

$builder->create_build_script();