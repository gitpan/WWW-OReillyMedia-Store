package WWW::OReillyMedia::Store;

use strict; use warnings;

=head1 NAME

WWW::OReillyMedia::Store - Interface to the OReilly Media Store.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

use Carp;
use Readonly;
use Data::Dumper;
use HTTP::Request;
use LWP::UserAgent;
use WWW::OReillyMedia::Store::Book;

Readonly my $URL =>
[
    'http://oreilly.com/store/complete.html',
    'http://oreilly.com/store/complete2.html',
    'http://oreilly.com/store/complete3.html',
    'http://oreilly.com/store/complete4.html'
];

sub new
{
    my $class = shift;
    my $self  = { books   => undef,
                  browser => LWP::UserAgent->new()
                };
    
    bless $self, $class;
    $self->fetch_books();
    return $self;
}

=head1 SYNOPSIS

Objective of this module is to provide an interface to the OReilly online media store. This is just an initial release. 
I will be adding more functionality really soon.

    use WWW::OReillyMedia::Store;

    my $store = WWW::OReillyMedia::Store->new();
    my $books = $store->get_all_books();

    print $books->[0]->as_string();
    print "Total Count: [" . $store->book_count() . "]\n"

=head1 METHODS

=head2 fetch_books()

Fetches books details from OReilly online store realtime. It does so as part of constructor
functionality. You DONT really need to do call this explicitly. However it is still there for
you to play with it.

=cut

sub fetch_books
{
    my $self    = shift;
    my $browser = $self->{browser};
    
    my ($books, $book);
    my ($request, $response, $contents);
        
    foreach (@{$URL})
    {
        $request  = HTTP::Request->new(GET=>$_);
        $response = $browser->request($request);
        croak("ERROR: Couldn't connect to search.cpan.org.\n") 
            unless $response->is_success;
    
        $contents = $response->content;
        foreach (split(/\n/,$contents))
        {
            chomp;
            s/^\s+//g;
            s/\s+$//g;
            next if /^$/;
            
            if (/\<a class\=\"tt\" id=\"(.*)\" href=\"(.*)\"\>(.*)/)
            {
                push @$books, WWW::OReillyMedia::Store::Book->new($book) if defined $book;
                $book = undef;
                $book->{id}   = $1;
                $book->{url}  = $2;
                $book->{desc} = $3;
            }
            elsif (/^[A-Z][a-z][a-z]\s\d{4}\<\/td\>$/) 
            {
                /(.*)\<\/td\>/;
                $book->{released} = $1;
            }
            elsif (/^\$\d+?\.\d+$/) 
            {
                /^\$(.*)$/;
                $book->{price} = '$'.$1;
            }
            elsif (/^\<a href=\"(.*)\"\>.*Available as Ebook.*/)
            {
                $book->{ebook} = 1;
            }
            elsif (/^\<a href=\"(.*)\"\>.*Read it on online with Safari.*/)
            {
                $book->{online} = $1;
            }
        }
    }
    $self->{books} = $books;
}

=head2 search_book()

Search for a book in the book store. NOT YET defined.

=cut

sub search_book
{
    my $self  = shift;
    my $query = shift;
}

=head2 book_count()

Returns the total books count in the OReilly online store.

    use strict; use warnings;
    use WWW::OReillyMedia::Store;

    my $store = WWW::OReillyMedia::Store->new();
    print "Count: [" . $store->book_count() . "]\n"

=cut

sub book_count
{
    my $self = shift;
    return scalar(@{$self->{books}});
}

=head2 get_all_books()

Returns all the books that have been fetched from the OReilly online store. It returs a reference 
to the list of objects of class WWW::OReillyMedia::Store::Book.

    use strict; use warnings;
    use WWW::OReillyMedia::Store;

    my $store = WWW::OReillyMedia::Store->new();
    my $books = $store->get_all_books();
    print $books->[0]->as_string();

=cut

sub get_all_books
{
    my $self = shift;
    return $self->{books};
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-oreillymedia-store at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-OReillyMedia-Store>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::OReillyMedia::Store

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

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 DISCLAIMER

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut

1; # End of WWW::OReillyMedia::Store