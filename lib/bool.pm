use strict;
use warnings;
package bool;

use Scalar::Util ();

use strict;
use overload (
    "0+"     => sub { ${$_[0]} },
    "++"     => sub { $_[0] = ${$_[0]} + 1 },
    "--"     => sub { $_[0] = ${$_[0]} - 1 },
    fallback => 1,
);

use Exporter ();
BEGIN { @bool::ISA = ('Exporter') }

our ($TRUE, $FALSE);
our @EXPORT_OK = qw/ true false /;

sub new {
    my ($class, $num) = @_;
    return bless \$num, $class;
}

$TRUE = bool->new(1);
$FALSE = bool->new(0);

sub true { $TRUE }
sub false { $FALSE }

sub is_bool {
    Scalar::Util::blessed($_[0]) and $_[0]->isa("bool");
}

sub complement {
    $_[0] ? $FALSE : $TRUE
}

1;
