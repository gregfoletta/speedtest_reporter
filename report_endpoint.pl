#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
use Pod::Usage;
use Getopt::Long;
use Mojolicious::Lite -signatures;
use Mojo::Util qw(url_unescape);
use JSON;

my %args;
GetOptions(
    \%args,
    'help' => sub { pod2usage(1) }
) or pod2usage(2);

=pod

=head1 NAME

=head1 SYNOPSIS

=cut

use Data::Dumper;

# Route with placeholder
post '/' => sub ($c) {
  $c->render(text => '');

  my $raw_string = url_unescape($c->req->body_params->to_string);

  print $raw_string;
  my @lines = split("\n", $raw_string);

  # Pop off the last line
  pop @lines;
  my $raw_json = join '', @lines[7..$#lines];
  my $json = decode_json($raw_json);

  print Dumper $json;

};

# Start the Mojolicious command system
app->start('daemon', '-l', 'http://*:8080');

