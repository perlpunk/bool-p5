use strict;
use warnings;
package bool;

use Exporter ();
BEGIN { @bool::ISA = ('Exporter') }

our @EXPORT_OK = qw/ true false /;
require JSON::PP;
@JSON::PP::Boolean::ISA = qw/ bool /;

use overload (
    "0+"     => \&_stringify,
    "++"     => \&_plus,
    "--"     => \&_minus,
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

sub is_bool {
    JSON::PP::is_bool(@_);
}

sub complement {
    $_[0] ? $FALSE : $TRUE
}

sub _stringify {
    ${ $_[0] }
}

sub _plus {
    $_[0] = ${ $_[0] } + 1
}

sub _minus {
    $_[0] = ${ $_[0] } - 1
}

sub perl {
    ${ $_[0] } ? 1 : ''
}

1;
