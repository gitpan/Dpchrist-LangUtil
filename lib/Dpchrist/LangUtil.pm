#######################################################################
# $Id: LangUtil.pm,v 1.3 2010-06-06 03:37:10 dpchrist Exp $
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
    defined_or
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw();

our $VERSION = sprintf("%d.%03d", q$Revision: 1.3 $ =~ /(\d+)/g);

#######################################################################

=head1 NAME

Dpchrist::LangUtil - Perl language utilities


=head1 DESCRIPTION

=head2 SUBROUTINES

=cut

#######################################################################

=head3 defined_or( ARGV... )

Returns first defined ARGV element,
or void.

=cut

#----------------------------------------------------------------------

sub defined_or
{
    foreach (@_) {
	return $_ if defined $_;
    }

    return;
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

    use Dpchrist::LanUtil         qw( :all ); 

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
