use strict;
use warnings;
package bool;

use Scalar::Util ();
use Exporter ();
BEGIN { @bool::ISA = ('Exporter') }

our @EXPORT_OK = qw/ true false /;

use overload (
    "0+"     => \&stringify,
    "++"     => \&plus,
    "--"     => \&minus,
    fallback => 1,
);

sub new {
    my ($class, $num) = @_;
    $num = $num ? 1 : 0;
    return bless \$num, $class;
}

my $TRUE = bool->new(1);
my $FALSE = bool->new(0);

sub true { $TRUE }
sub false { $FALSE }

sub is_bool {
    Scalar::Util::blessed($_[0]) and $_[0]->isa("bool");
}

sub complement {
    $_[0] ? $FALSE : $TRUE
}

sub stringify {
    ${ $_[0] }
}

sub plus {
    $_[0] = ${ $_[0] } + 1
}

sub minus {
    $_[0] = ${ $_[0] } - 1
}

sub perl {
    ${ $_[0] } ? 1 : ''
}

1;
