use strict;
use warnings;
package bool;

# WIP
# A replacement for JSON::PP::Boolean
# This would work for any module checking for isa('JSON::PP::Boolean')
# without changing anything
# But apparently JSON::XS, Cpanel::JSON::XS, JSON::Tiny and Mojo::JSON are
# checking the ref() directly. Only JSON::PP works with this out of the box

our $VERSION = '0.001';

use base 'Exporter';

use Scalar::Util ();

our @EXPORT_OK = qw/ true false is_bool /;

# for historical reasons
push @bool::ISA, qw/ JSON::PP::Boolean /;
# otherwise we get a complaint that the package does not exist, if it isn't
# used
$JSON::PP::Boolean::_dummy_variable = 23;

use overload (
    "0+"     => \&stringify,
    "++"     => \&_plus_one,
    "--"     => \&_minus_one,
    fallback => 1,
);

sub new {
    my $num = $_[1] ? 1 : 0;
    return bless \$num, $_[0];
}

my $TRUE = do { bless \(my $dummy = 1), 'bool' };
my $FALSE = do { bless \(my $dummy = 0), 'bool' };

sub true() { $TRUE }
sub false() { $FALSE }

sub is_bool {
    Scalar::Util::blessed($_[0]) and $_[0]->isa('bool');
}

sub not {
    $_[0] ? $FALSE : $TRUE
}

sub stringify {
    ${ $_[0] }
}

sub _plus_one {
    $_[0] = ${ $_[0] } + 1
}

sub _minus_one {
    $_[0] = ${ $_[0] } - 1
}

sub perl {
    ${ $_[0] } ? 1 : ''
}


1;
