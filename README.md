# GSheet2TSV version 0.01

Given a Google Spreadsheet key, pulls down the contents as a tab-delimited
file, appending the new results to an older log file while creating a new
file with the latest updates for processing in another application.

## INSTALLATION

To install this module type the following:

*   perl Makefile.PL
*   make
*   make test

## CONFIGURATION

Alter the _gsheet.conf_ file in the root directory to enter your Google
Spreadsheet key and the location of the log and new files.

## EXECUTION

Run _pull.pl_ in the root directory to pull down your spreadsheet results.

## BUGS

* more tests should be used
* blank lines could be an issue depending on the stage they occur
* more options may be need in the future such as sheet number or more delimiators

## DEPENDENCIES

This module requires these other modules and libraries:

>  LWP::Simple

## COPYRIGHT AND LICENCE

Copyright (C) 2016 by Stephen Wells

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.22.1 or,
at your option, any later version of Perl 5 you may have available.

