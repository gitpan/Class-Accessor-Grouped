package AccessorGroupsRO;
use strict;
use warnings;
use base 'Class::Accessor::Grouped';

__PACKAGE__->mk_group_ro_accessors('single', 'singlefield');
__PACKAGE__->mk_group_ro_accessors('multiple', qw/multiple1 multiple2/);
__PACKAGE__->mk_group_ro_accessors('listref', [qw/lr1name lr1;field/], [qw/lr2name lr2'field/]);

sub new {
    return bless {}, shift;
};

foreach (qw/single multiple listref/) {
    no strict 'refs';

    *{"get_$_"} = \&Class::Accessor::Grouped::get_simple;
};

1;
