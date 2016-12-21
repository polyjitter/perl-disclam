#!/usr/bin/env perl

package Discord;

use strict;
use warnings;

sub new {
    my ( $class, %params ) = @_;
    my $self = {};

    # Store the token, application name, url, and version
    $self->{'token'}   = $params{'token'};
    $self->{'name'}    = $params{'name'};
    $self->{'url'}     = $params{'url'};
    $self->{'version'} = $params{'version'};

    # Store verbosity settings
    $self->{'verbose'} = $params{'verbose'} if defined $params{'verbose'};

    # Store the reconnect setting
    $self->{'reconnect'} = $params{'reconnect'} if defined $params{'reconnect'};

    # Store the callbacks if they exist
    $self->{'callbacks'} = $params{'callbacks'} if exists $params{'callbacks'};

    # API Vars - Will need to be updated if the API changes
    $self->{'base_url'} = 'https://discordapp.com/api';

    # Create the Gateway and REST objects
    # my $gw                  = Net::Discord::Gateway->new(%{$self});
    my $api                = Net::Discord::REST->new(%{$self});
    #
    # $self->{'gw'}           = $gw;
    $self->{'api'}         = $api;

    bless $self, $class;
    return $self;
}
