#! /bin/sh

# Copyright 2022 Dávid Csaba Mezőfi

# Copying and distribution of this file, with or without modification, are
# permitted in any medium without royalty provided the copyright notice and
# this notice are preserved.  This file is offered as-is, without any warranty.

# https://www.adobe.com/acrobat/hub/how-to/how-to-compress-pdf-in-linux

usage() {
    echo "usage: shrinkpdf.sh [-h] [-s|-e|-p] [-o outfile] [infile]" >&2
}

longhelp() {
	echo
	cat << EOF
The script shrinkpdf.sh uses Ghostscript to try to reduce the size of the PDF
file provided in infile or on the standard input.  The quality of the output
may be set using the -s -e -p options.  These options are mutually exclusive
but optional.  Their meaning are the following:

	-s	low resulotion output (screen)
	-e	medium resulotion output (ebook)
	-p	print optimized output (print)

In the absence of the -o outfile option the scripts outputs the the standard
output (instead of the specified outfile).

For further information please refer to the man page of gs (man gs) or the
Ghostscript documentation on your system.
EOF
}

if ! TEMP=$(getopt -o '+sepho:' -n 'shrinkpdf.sh' -- "$@")
then
    usage
    exit 1
fi

OUTFILE=-
CONFIGURATION=/default


eval set -- "$TEMP"
unset TEMP
while true
do
    case "$1" in
        '-h')
            usage
			longhelp >&2
            exit 0
			;;
        '-s')
			[ "$CONFIGURATION" != "/default" ] && {
				usage
				exit 1
			}
            CONFIGURATION=/screen
            shift
            continue
            ;;
        '-e')
			[ "$CONFIGURATION" != "/default" ] && {
				usage
				exit 1
			}
            CONFIGURATION=/ebook
            shift
            continue
            ;;
        '-p')
			[ "$CONFIGURATION" != "/default" ] && {
				usage
				exit 1
			}
            CONFIGURATION=/printer
            shift
            continue
            ;;
        '-o')
            OUTFILE="$2"
            shift 2
            continue
            ;;
        '--')
            shift
            break
            ;;
        *)
            echo "shrinkpdf.sh: error during parsing options" >&2 
            usage
            exit 2
            ;;
    esac
done

INFILE=-
[ $# -eq 1 ] && {
	[ ! -f "$1" ] && echo "shrinkpdf.sh: $1 doesn't exist" >&2 && usage && \
		exit 3
	INFILE="$1"
}

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS="$CONFIGURATION" \
    -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$OUTFILE" "$INFILE" && exit 0
exit 4
