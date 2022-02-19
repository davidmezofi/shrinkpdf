Copyright 2022 Dávid Csaba Mezőfi

Copying and distribution of this file, with or without modification, are
permitted in any medium without royalty provided the copyright notice and this
notice are preserved.  This file is offered as-is, without any warranty.


                                 SHRINKPDF.SH

The script shrinkpdf.sh uses Ghostscript to (try to) reduce the size of the PDF
file provided in infile or on the standard input (by default).  The "quality"
of the output may be set using the -s -e -p options.  These options are
mutually exclusive but optional.  The following options are available:

    -h  Print this help and exit
    -s  Low resulotion output, PDFSETTTINGS is set to /screen
    -e  Medium resulotion output, PDFSETTTINGS is set to /ebook
    -p  Print optimized output, PDFSETTTINGS is set to /printer
    -o outfile
        The script outputs to outfile, instead of the standard output (default
        behaviour)

Note that the options must come first when invoking the script.  The exit
status can be one of the following:

    0   The execution of the script was succesful
    1   Invalid options or combination of options
    2   infile doesn't exist
    3   Some other error occurred

For further information please refer to the man page of gs (man gs) or the
Ghostscript documentation on your system.

The idea of the script is based on the article

    https://www.adobe.com/acrobat/hub/how-to/how-to-compress-pdf-in-linux
