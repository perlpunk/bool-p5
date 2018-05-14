use strict;
use warnings;
package bool;

use Exporter ();
BEGIN { @bool::ISA = ('Exporter') }

our $VERSION = '0.001';

our @EXPORT_OK = qw/ true false /;
push @JSON::PP::Boolean::ISA, qw/ bool /;

use overload (
    "0+"     => \&stringify,
    "++"     => \&_plus_one,
    "--"     => \&_minus_one,
    fallback => 1,
);

sub new {
    my ($class, $num) = @_;
    $num = $num ? 1 : 0;
    return bless \$num, $class;
}

my $TRUE = do { bless \(my $dummy = 1), "JSON::PP::Boolean" };
my $FALSE = do { bless \(my $dummy = 0), "JSON::PP::Boolean" };

sub true { $TRUE }
sub false { $FALSE }

BEGIN {
    unless (eval { require Scalar::Util; 1 }) {
        *bool::_blessed = \&Scalar::Util::blessed;
    }
    else { # This code is from Scalar::Util.
        eval 'sub UNIVERSAL::a_sub_not_likely_to_be_here { ref($_[0]) }';
        *bool::_blessed = sub {
            local($@, $SIG{__DIE__}, $SIG{__WARN__});
            ref($_[0]) ? eval { $_[0]->a_sub_not_likely_to_be_here } : undef;
        };
    }
}

sub is_bool {
    _blessed $_[0] and $_[0]->isa("bool");
}

sub complement {
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
