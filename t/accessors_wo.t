use Test::More tests => 38;
use Test::Exception;
use strict;
use warnings;
use lib 't/lib';

# we test the pure-perl versions only, but allow overrides
# from the accessor_xs test-umbrella
# Also make sure a rogue envvar will not interfere with
# things
my $use_xs;
BEGIN {
    $Class::Accessor::Grouped::USE_XS = 0
        unless defined $Class::Accessor::Grouped::USE_XS;
    $ENV{CAG_USE_XS} = 1;
    $use_xs = $Class::Accessor::Grouped::USE_XS;
};

use AccessorGroupsWO;

my $class = AccessorGroupsWO->new;

{
    my $warned = 0;

    local $SIG{__WARN__} = sub {
        if  (shift =~ /DESTROY/i) {
            $warned++;
        };
    };

    $class->mk_group_wo_accessors('warnings', 'DESTROY');

    ok($warned);

    # restore non-accessorized DESTROY
    no warnings;
    *AccessorGroupsWO::DESTROY = sub {};
};

my $test_accessors = {
    singlefield => {
        is_xs => $use_xs,
    },
    multiple1 => {
    },
    multiple2 => {
    },
    lr1name => {
        custom_field => 'lr1;field',
    },
    lr2name => {
        custom_field => "lr2'field",
    },
};

for my $name (sort keys %$test_accessors) {

    my $alias = "_${name}_accessor";
    my $field = $test_accessors->{$name}{custom_field} || $name;

    can_ok($class, $name, $alias);

    ok(!$class->can($field))
      if $field ne $name;

    # set via name
    is($class->$name('a'), 'a');
    is($class->{$field}, 'a');

    # alias sets same as name
    is($class->$alias('b'), 'b');
    is($class->{$field}, 'b');

    my $wo_regex = $test_accessors->{$name}{is_xs}
        ? qr/Usage\:.+$name.*\(self, newvalue\)/
        : qr/cannot access the value of '\Q$field\E'/
    ;

    # die on get via name/alias
    throws_ok {
        $class->$name;
    } $wo_regex;

    throws_ok {
        $class->$alias;
    } $wo_regex;
};

# important
1;