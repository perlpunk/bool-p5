use strict;
use warnings;
use Test::More tests => 20;

use bool;

my $true = bool::true;
my $false = bool::false;
my $new_true = bool->new(1);
my $new_false = bool->new(0);

ok(bool::is_bool($true), 'is_bool($true)');
ok(bool::is_bool($false), 'is_bool($false)');
ok(bool::is_bool($new_true), 'is_bool($new_true)');
ok(bool::is_bool($new_false), 'is_bool($new_false)');

ok($true, '$true is true');
ok(!$false, '$false is false');
ok($new_true, '$new_true is true');
ok(!$new_false, '$new_false is false');

ok(!$true == $false, '!$true == $false');
ok(!$false == $true, '!$false == $true');

cmp_ok(++$false, '==', 1, '++$bool == 1');
$false = bool::false;

cmp_ok("$true", 'eq', 1, '$true eq 1');
cmp_ok("$false", 'eq', 0, '$false eq 0');

cmp_ok($true->perl, 'eq', 1, '$true->perl eq 1');
cmp_ok($false->perl, 'eq', '', '$false->perl eq ""');

my $isa = bool::is_bool($true) ? 1 : 0;
ok($isa, "\$true is a bool");

$isa = bool::is_bool(bless {}, 'Nonsense') ? 1 : 0;
ok(! $isa, "some object is not a bool");

$isa = bool::is_bool(\{ foo => 'bar' }) ? 1 : 0;
ok(! $isa, "some ref is not a bool");

ok($true->not == $false, '$true->not == $false');
ok($false->not == $true, '$false->not == $true');
