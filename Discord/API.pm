package Discord::API;

use strict;
use warnings;

use Mojo::UserAgent;

sub new {
    my ( $class, %params ) = @_;
    my $self = {};

    # Store the token, application name, url, and version
    $self->{'token'} = $params{'token'};

    # API Vars - Will need to be updated if the API changes
    $self->{'base_url'} = 'https://discordapp.com/api';
    $self->{'name'}     = $params{'name'};
    $self->{'url'}      = $params{'url'};
    $self->{'version'}  = $params{'version'};

    # Other vars
    $self->{'agent'} =
      $self->{'name'} . ' (' . $self->{'url'} . ',' . $self->{'version'} . ')';

    my $ua = Mojo::UserAgent->new;
    $ua->transactor->name( $self->{'agent'} );

    # Make sure the token is added to every request automatically.
    $ua->on(
        start => sub {
            my ( $ua, $tx ) = @_;
            $tx->req->headers->authorization( "Bot " . $self->{'token'} );
        }
    );

    $self->{'ua'} = $ua;

    bless $self, $class;
    return $self;
}
