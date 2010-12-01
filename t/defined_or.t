#######################################################################
# $Id: defined_or.t,v 1.2 2010-11-18 19:26:14 dpchrist Exp $
#
# Test script for Dpchrist::LangUtil::defined_or().
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

use Test::More tests => 5;

use Data::Dumper;

use Dpchrist::LangUtil	qw (defined_or );

my $t;

$t = eval {
    defined_or();
};
ok( !defined $t,						#     1
    "call with no arguments should return undefined value"
    . Data::Dumper->Dump([$t, $@], [qw(t @)]),
);


$t = eval {
    defined_or(undef);
};
ok( !defined $t,						#     2
    "call with argument (undef) should return undefined value"
    . Data::Dumper->Dump([$t, $@], [qw(t @)]),
);


$t = eval {
    defined_or("foo");
};
ok( $t eq "foo",						#     3
    "call with argument (\"foo\") should return \"foo\""
    . Data::Dumper->Dump([$t, $@], [qw(t @)]),
);


$t = eval {
    defined_or(undef, "bar");
};
ok( $t eq "bar",						#     4
    "call with arguments (undef, \"bar\") should return \"bar\""
    . Data::Dumper->Dump([$t, $@], [qw(t @)]),
);


$t = eval {
    defined_or(undef, undef, "baz");
};
ok( $t eq "baz",						#     5
    "call with arguments (undef, undef, \"baz\") should return \"baz\""
    . Data::Dumper->Dump([$t, $@], [qw(t @)]),
);

#######################################################################
