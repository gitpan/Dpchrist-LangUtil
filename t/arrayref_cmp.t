#######################################################################
# $Id: arrayref_cmp.t,v 1.3 2010-12-14 05:25:03 dpchrist Exp $
#
# Test script for Dpchrist::LangUtil::arrayref_cmp().
#
# Copyright (c) 2010 by David Paul Christensen dpchrist@holgerdanske.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
# USA.
#######################################################################

use Test::More tests => 13;

use Data::Dumper;

use Dpchrist::LangUtil	qw (arrayref_cmp );

my $e;

use constant A123	=> (1, 2, 3);
use constant EMPTY	=> ();

my @a123 = (1, 2, 3);
my @a12u = (1, 2, undef);
my @empty = ();

$e = eval {
    arrayref_cmp();
};
ok( $@,								#     1
    "call with no arguments should throw exception",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp(@a123, @a123);
};
ok( $@,								#     2
    "call with two scalar array arguments should throw exception",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp(\@a123, @a123);
};
ok( $@,								#     3
    "call with array reference and array arguments " .
    "should throw exception",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp(@a123, \@a123);
};
ok( $@,								#     4
    "call with array and array reference arguments " .
    "should throw exception",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp([], []);
};
ok( $e == 0,							#     5
    "call with two empty anonymous arrays should return 0",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp([], \@empty);
};
ok( $e == 0,							#     6
    "call with empty anonymous and lexical arrays should return 0",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp([], [EMPTY]);
};
ok( $e == 0,							#     7
    "call with empty anonymous and constant arrays should return 0",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp([1, 2, 3], [1, 2, 3]);
};
ok( $e == 0,							#     8
    "call with identical anonymous arrays should return 0",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp([1, 2, 3], \@a123);
};
ok( $e == 0,							#     9
    "call with equal anonymous and lexical arrays should return 0",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp([1, 2, 3], [A123]);
};
ok( $e == 0,							#    10
    "call with equal anonymous and constant arrays should return 0",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {
    arrayref_cmp([], [1, 2, 3]);
};
ok( $e == -1,							#    11
    "call with empty and non-empty anonymous arrays should return -1",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {							#    12
    arrayref_cmp([1, 2, 3], []);
};
ok( $e == 1,
    "call with non-empty and empty arrays should return 1",
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

$e = eval {							#    13
    arrayref_cmp(\@a123, \@a12u);
};
ok(
    !$@
    && $e == -1,
    'call with array and array containing undef ' .
    'should return -1'
) or die join("\n",
    Data::Dumper->Dump([$@, $e], [qw(@ e)]),
);

