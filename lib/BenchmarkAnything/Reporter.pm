use 5.008;
use strict;
use warnings;
package BenchmarkAnything::Reporter;
# ABSTRACT: Handle result reporting to a BenchmarkAnything HTTP/REST API

=head2 new

Instantiate a new object.

=over 4

=item * config

Path to config file. If not provided it uses env variable
C<BENCHMARKANYTHING_CONFIGFILE> or C<$home/.benchmarkanything.cfg>.

=item * verbose

Print out progress messages.

=back

=cut

sub new
{
        my $class = shift;
        my $self  = bless { @_ }, $class;

        require BenchmarkAnything::Config;
        $self->{config} = BenchmarkAnything::Config->new unless $self->{config};

        return $self;
}

=head2 report ($data)

Reports all data points of a BenchmarkAnything structure to the
configured HTTP/REST URL.

=cut

sub report
{
        my ($self, $data) = @_;

        # --- validate ---
        if (not $data)
        {
                die "benchmarkanything: no input data provided.\n";
        }

        my $ua  = $self->_get_user_agent;
        my $url = $self->_get_base_url."/api/v1/add";
        print "Report data...\n" if $self->{verbose} or $self->{debug};
        my $res = $ua->post($url => json => $data)->res;
        print "Done.\n" if $self->{verbose} or $self->{debug};

        die "benchmarkanything: ".$res->error->{message}." ($url)\n" if $res->error;

        return $self;
}

sub _get_user_agent
{
        require Mojo::UserAgent;
        return Mojo::UserAgent->new;
}

sub _get_base_url
{
        $_[0]->{config}{benchmarkanything}{backends}{http}{base_url};
}

1;
3
