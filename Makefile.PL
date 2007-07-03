# $Id: /local/Class-Accessor-Grouped/Makefile.PL 1700 2007-07-02T01:08:11.474048Z claco  $
use strict;
use warnings;
use inc::Module::Install 0.65;

name 'Class-Accessor-Grouped';
license 'perl';
perl_version '5.006001';
all_from 'lib/Class/Accessor/Grouped.pm';

requires 'Carp';
requires 'Scalar::Util';
requires 'MRO::Compat';
requires 'Class::Inspector';

tests "t/*.t t/*/*.t";
clean_files "Class-Accessor-Grouped-* t/var";

auto_install;

WriteMakefile(
  dist => {
    PREOP => 'pod2text lib/Class/Accessor/Grouped.pm > README'
  }
);
