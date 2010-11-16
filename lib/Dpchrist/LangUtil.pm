#######################################################################
# $Id: LangUtil.pm,v 1.6 2010-11-15 23:29:45 dpchrist Exp $
#######################################################################
# package:
#----------------------------------------------------------------------

package Dpchrist::LangUtil;

use 5.010000;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw(
    array_cmp
    defined_or
    hashref_keys
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw();

our $VERSION = sprintf("%d.%03d", q$Revision: 1.6 $ =~ /(\d+)/g);

#######################################################################
# uses:
#----------------------------------------------------------------------

use Carp;
use Data::Dumper;

#######################################################################

=head1 NAME

Dpchrist::LangUtil - Perl language utilities


=head1 DESCRIPTION

=cut

#######################################################################

=head2 SUBROUTINES

=cut

#----------------------------------------------------------------------

=head3 array_cmp

    array_cmp ARRAYREF,ARRAYREF

Applies '<=>' (spaceship) operator to array lengths and then
applies 'cmp' operator to array elements in turn.
Returns first non-zero comparison result encountered,
or zero if arrays have equal length
and if all corresponding elements are equal strings.

Calls confess() on error.

=cut

sub array_cmp
{
    confess join(' ',
	'ERROR: arguments must be two array references',
	Data::Dumper->Dump([\@_], [qw(*_)]),
    ) unless @_ == 2
	&& ref($_[0]) eq 'ARRAY'
	&& ref($_[1]) eq 'ARRAY';

    my $retval = @{$_[0]} <=> @{$_[1]};
    my $i = 0;
    while($retval == 0 && $i < scalar @{$_[0]}) {
	$retval = $_[0][$i] cmp $_[1][$i];
	$i++;
    }

    return $retval;
}

#----------------------------------------------------------------------

=head3 defined_or

    defined_or LIST

Returns first defined LIST element,
void if LIST is empty,
or void if all LIST elements are the undefined value.

=cut

sub defined_or
{
    foreach (@_) {
	return $_ if defined $_;
    }

    return;
}

#----------------------------------------------------------------------

=head3 hashref_keys

    hashref_keys HASHREF

Returns keys of hash reference.

Calls confess() on error.

=cut

sub hashref_keys
{
    my $rh = shift;
    confess join(' ',
       	"ERROR: argument is not a hash reference",
	Data::Dumper->Dump([\@_], [qw(*_)]),
    ) unless $rh && ref $rh && ref $rh eq "HASH";
    my %h = %$rh; 
    return keys %h;
}

#######################################################################
# end of code:
#----------------------------------------------------------------------

1;

__END__

#######################################################################

=head2 EXPORT

None by default.

All of the subroutines may be imported by using the ':all' tag:

    use Dpchrist::LangUtil         qw( :all ); 

    See 'perldoc Export' for everything in between.


=head1 INSTALLATION

    perl Makefile.PL
    make    
    make test
    make install 


=head1 DEPENDENCIES

    Dpchrist::Module


=head1 AUTHOR

David Paul Christensen dpchrist@holgerdanske.com



=head1 COPYRIGHT AND LICENSE

Copyright 2010 by David Paul Christensen dpchrist@holgerdanske.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 2.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
USA.

=cut

#######################################################################
