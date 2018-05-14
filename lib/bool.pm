use strict;
use warnings;
package bool;

our $VERSION = '0.001';

use base 'Exporter';

use Scalar::Util ();

our @EXPORT_OK = qw/ true false /;

use overload (
    "0+"     => \&stringify,
    "++"     => \&plus_one,
    "--"     => \&minus_one,
    fallback => 1,
);

sub new {
    my $num = $_[1] ? 1 : 0;
    return bless \$num, $_[0];
}

my $TRUE = do { bless \(my $dummy = 1), 'bool' };
my $FALSE = do { bless \(my $dummy = 0), 'bool' };

sub true { $TRUE }
sub false { $FALSE }

sub is_bool {
    Scalar::Util::blessed($_[0]) and $_[0]->isa('bool');
}

sub not {
    $_[0] ? $FALSE : $TRUE
}

sub stringify {
    ${ $_[0] }
}

sub plus_one {
    $_[0] = ${ $_[0] } + 1
}

sub minus_one {
    $_[0] = ${ $_[0] } - 1
}

sub perl {
    ${ $_[0] } ? 1 : ''
}


1;
