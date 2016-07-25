package GSheet2TSV;

use 5.022001;
use strict;
use warnings;

use LWP::Simple;
#use Text::ParseWords;

our $VERSION = '0.01';

sub new {
    my ($class, $args) = @_;

  return bless $args, $class;
}

sub pull {
    my ($self) = @_;

    my $contents = LWP::Simple::get(
	'https://docs.google.com/spreadsheets/u/0/d/'.
	$self->{spreadsheet_key}.
	'/export?format=tsv&id='.
	$self->{spreadsheet_key}.
	'&gid=0'
    );

    die "couldn't get content - recheck your key" unless $contents;

    my $log_file = $self->{log_output};
    my $new_file = $self->{new_output};

    # snatch up the last line of the log file
    my $log_match;
    if (-e $log_file) {
        open (LOG, '<', $log_file) or die "can't read log_output: $log_file: $!";
          # we only need the last line...
          chomp(my @lines = <LOG>);
	  $log_match = $lines[-1] || $lines[-2];
        close(LOG);
    }

    if (! defined($log_match)) {
        open (LOG, '>', $log_file) or die "can't create log_output: $log_file: $!";
	  print LOG $contents;
	close(LOG);

	open (NEW, '>', $new_file) or die "can't create new_output: $new_file: $!";
	  print NEW $contents;
	close(NEW);

      return;
    }

    my @new_lines = map { s/[\r\n\cM]+//g; $_ }  split(/^/, $contents);

    open (LOG, '>>', $log_file) or die "can't append log_output: $log_file: $!";
    open (NEW, '>', $new_file) or die "can't create new_output: $new_file: $!";

    my $start_writing = 0;
    for (@new_lines) {
	if ($start_writing) {
           print LOG $_, "\n";
           print NEW $_, "\n";
	   next;
        }	   
        next unless /^$log_match$/;
        $start_writing++;
    }

  return;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

GSheet2TSV - Pull down new occurances from a Google Sheet

=head1 SYNOPSIS

  use GSheet2TSV;

  my $g2t = GSheet2TSV({
     spreadsheet_key => '1mhYcqIYBu6WW-SVtE4I0soptkeiD8MIk9fmZYpY',
     log_file => 'data/myfile.log',
     new_file => 'data/newfile.tsv'
  });


=head1 DESCRIPTION

Given a Google Spreadsheet key, pulls down the contents as a tab-delimited
file, appending the new results to an older log file while creating a new
file with the latest updates for processing in another application.

=head2 EXPORT

None by default.

=head1 SEE ALSO

LWP::Simple;

=head1 AUTHOR

Steve Wells, E<lt>wells@cedarnet.org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Steve Wells

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.22.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
