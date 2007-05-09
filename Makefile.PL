# $Id: Makefile.PL 3271 2007-05-09 01:55:34Z claco $
use strict;
use warnings;
use inc::Module::Install 0.65;

name 'Class-Accessor-Grouped';
license 'perl';
perl_version '5.006001';
all_from 'lib/Class/Accessor/Grouped.pm';

requires 'Carp';
requires 'Scalar::Util';
requires 'Class::ISA';
requires 'Class::Inspector';

tests "t/*.t t/*/*.t";
clean_files "Class-Accessor-Grouped-* t/var";

eval {
    system 'pod2text lib/Class/Accessor/Grouped.pm > README';
};

auto_install;
WriteAll;
