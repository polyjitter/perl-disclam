package Discord::API;

use strict;
use warnings;

use Try::Tiny;
use Mojo::UserAgent;
use Mojo::JSON;

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

sub send_message {
    my ( $self, $dest, $content ) = @_;

    if (exists $params{'tts'}) {
        my $tts = $params{'tts'};
    } else {
        my $tts = Mojo::JSON::false
    };

    my $post_url = $self->{'base_url'} . "/channels/$dest/messages";

    my $tx =
      $self->{'ua'}->post(
        $post_url => { Accept => '*/*' } => json => {
            'content' => $content,
            'tts'     => $tts
        }
    );
}

sub delete_message {
    my ( $self, $dest, %messageid ) = @_;

    my $delete_url =
      $self->{'base_url'} . "/channels/$dest/messages/$messageid";

    my $tx =
      $self->{'ua'}->delete( $delete_url );
}

1;
