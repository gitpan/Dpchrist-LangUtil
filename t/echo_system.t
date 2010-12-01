# $Id: echo_system.t,v 1.7 2010-11-30 20:20:15 dpchrist Exp $

use Test::More tests => 2;

use strict;
use warnings;


use Capture::Tiny		qw( capture );
use Carp;
use Data::Dumper;
use Dpchrist::LangUtil		qw( echo_system );

$Data::Dumper::Sortkeys = 1;

my $line;
my $r;
my $stderr;
my $stdout;


$line = "echo 'hello, world!'";
($stdout, $stderr) = capture {
    $r = eval { 
	echo_system $line;
    };
};
ok(								#     1
    !$@
    && $r == 0
    && $stdout =~ /$line\nhello\, world\!\n$/
    && $stderr eq ''
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$line, $r, $stdout, $stderr, $@],
		     [qw(line   r   stdout   stderr   @)])
);

$line = "nosuchcommand";
($stdout, $stderr) = capture {
    $r = eval {
	echo_system $line;
    };
};
ok(								#     2
    !$@
    && $r
    && $stdout =~ /$line\n$/
    && $stderr =~ /Can't exec "$line": No such file or directory/
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$line, $r, $stdout, $stderr],
		     [qw(line   r   stdout   stderr)])
);

