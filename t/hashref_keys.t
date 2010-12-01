#######################################################################
# $Id: hashref_keys.t,v 1.2 2010-11-18 19:26:14 dpchrist Exp $
#
# Test script for Dpchrist::LangUtil::hashref_keys().
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

use strict;
use warnings;

use Test::More tests => 13;

use Dpchrist::LangUtil	qw (hashref_keys );

use constant S   =>  "constant string";
use constant A   => ("constant", "array");
use constant RA  => ["constant", "arrayref"];
use constant RH  => {-constant => 1, -hashref => 2};

use Carp;
use Data::Dumper;

local $Data::Dumper::Sortkeys = 1;

$| = 1;

my $s = "string";
my $rs = \$s;
my @a = (1, 2, 3);
my $ra = \@a;
my %h  = (-a => "b", -c => "d");
my $rh = \%h;


my @r;

@r = eval {
    hashref_keys;
};
ok(								#     1
    $@,
    "call with no arguments should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys undef;
};
ok(								#     2
    $@,
    "call on undefined value should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys "foo";
};
ok(								#     3
    $@,
    "call on string should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys S;
};
ok(								#     4
    $@,
    "call on constant scalar should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys A;
};
ok(								#     5
    $@,
    "call on constant array should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys RA;
};
ok(								#     6
    $@,
    "call on constant array reference should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys RH;
};
ok(								#     7
    scalar @r == 2
    && grep("-constant", @r)
    && grep("-hashref", @r),
    "call on constant hash reference should return keys"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys $s;
};
ok(								#     8
    $@,
    "call on scalar should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys $rs;
};
ok(								#     9
    $@,
    "call on scalar reference should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys @a;
};
ok(								#    10
    $@,
    "call on array should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys $ra;
};
ok(								#    11
    $@,
    "call on array reference should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys %h;
};
ok(								#    12
    $@,
    "call on hash should throw exception"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

@r = eval {
    hashref_keys $rh;
};
ok(								#    13
    scalar @r == 2
    && grep("a", @r)
    && grep("c", @r),
    "call on hash reference should return keys"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([\@r, $@], [qw(*r @)])
);

#######################################################################
