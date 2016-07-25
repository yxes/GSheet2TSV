#!/usr/bin/env perl
use lib 'lib';

use LWP::Simple;

BEGIN {
  require "gsheet.conf";
}

use GSheet2TSV;

my $g2c = GSheet2TSV->new($config);

$g2c->pull();

