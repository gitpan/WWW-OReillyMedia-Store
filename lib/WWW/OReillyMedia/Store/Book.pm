package WWW::OReillyMedia::Store::Book;

use strict; use warnings;

use overload q("") => \&as_string, fallback => 1;

=head1 NAME

WWW::OReillyMedia::Store::Book - Placeholder for the OReilly books.

=head1 VERSION

Version 0.05

=cut

our $VERSION = '0.05';

use Carp;
use Data::Dumper;

sub new
{
    my $class = shift;
    my $param = shift;
    
    bless $param, $class;
    return $param;
}

=head1 METHODS

=head2 get_id()

Return the unique ID of the book.

=cut

sub get_id
{
    my $self = shift;
    return $self->{id};
}

=head2 get_url()

Return the URL for the book.

=cut

sub get_url
{
    my $self = shift;
    return $self->{url};
}

=head2 get_description()

Return the book description.

=cut

sub get_description
{
    my $self = shift;
    return $self->{desc};
}

=head2 get_price()

Return the book price in US Dollars.

=cut

sub get_price
{
    my $self = shift;
    return $self->{price};
}

=head2 get_released()

Return the release date of the book.

=cut

sub get_released
{
    my $self = shift;
    return $self->{released};
}

=head2 is_ebook_available()

return 1 or 0 depending whether the ebook is available or not.

=cut

sub is_ebook_available
{
    my $self = shift;
    return 0
        unless exists($self->{ebook});
    return 1;    
}

=head2 is_available_online()

Return 1 or 0 depending whether the book is available online or not.

=cut

sub is_available_online
{
    my $self = shift;
    return 0
        unless exists($self->{online});
    return $self->{online};    
}

=head2 as_string()

Return books details in a nice human readable format.

=cut

sub as_string
{
    my $self = shift;
    my $map  = 
    {
        'id'          => '              Id: ',
        'description' => '     Description: ',
        'url'         => '             URL: ',
        'price'       => '           Price: $',
        'released'    => '        Released: ',
        'ebook'       => ' EBook Available: ',
        'online'      => 'Online Available: ',  
    };
    
    my $ebook  = ($self->is_ebook_available())?('Yes'):('No');
    my $online = ($self->is_available_online())?('Yes'):('No');
    my $string = $map->{id} . $self->get_id() . "\n";
    $string   .= $map->{description} . $self->get_description() . "\n";
    $string   .= $map->{url} . $self->get_url() . "\n";
    $string   .= $map->{price} . $self->get_price() . "\n";
    $string   .= $map->{released} . $self->get_released() . "\n";
    $string   .= $map->{ebook} . "$ebook\n";
    $string   .= $map->{online} . "$online\n";

    return $string;
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-oreillymedia-store at rt.cpan.org>  or
through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-OReillyMedia-Store>.  
I will be notified,  and  then you will automatically be notified of progress on your bug as I
make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::OReillyMedia::Store::Book

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-OReillyMedia-Store>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-OReillyMedia-Store>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-OReillyMedia-Store>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-OReillyMedia-Store/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Mohammad S Anwar.

This  program  is  free  software; you can redistribute it and/or modify it under the terms of
either:  the  GNU  General Public License as published by the Free Software Foundation; or the
Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 DISCLAIMER

This  program  is  distributed  in  the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


=cut

1; # End of WWW::OReillyMedia::Store::Book