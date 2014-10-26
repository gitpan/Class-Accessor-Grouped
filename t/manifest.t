#!perl -wT
# $Id: /bast/Class-Accessor-Grouped/trunk/t/manifest.t 5160 2008-11-18T02:10:02.602151Z claco  $
use strict;
use warnings;

BEGIN {
    use lib 't/lib';
    use Test::More;

    plan skip_all => 'set TEST_AUTHOR to enable this test' unless $ENV{TEST_AUTHOR};

    eval 'use Test::CheckManifest 0.09';
    if($@) {
        plan skip_all => 'Test::CheckManifest 0.09 not installed';
    };
};

ok_manifest({
    exclude => ['/t/var', '/cover_db'],
    filter  => [qr/\.(svn|git)/, qr/cover/, qr/Build(.(PL|bat))?/, qr/_build/, qr/\.DS_Store/],
    bool    => 'or'
});
