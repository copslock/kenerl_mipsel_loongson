Received:  by oss.sgi.com id <S553868AbQLRSrj>;
	Mon, 18 Dec 2000 10:47:39 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:27888 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553862AbQLRSr0>;
	Mon, 18 Dec 2000 10:47:26 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eBIIjVx21673;
	Mon, 18 Dec 2000 10:45:31 -0800
Message-ID: <3A3E5C14.F116DCBB@mvista.com>
Date:   Mon, 18 Dec 2000 10:48:52 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Keith Owens <kaos@melbourne.sgi.com>
CC:     Martin Michlmayr <tbm@cyrius.com>, linux-mips@oss.sgi.com
Subject: Re: Kernel Oops when booting on DECstation
References: <23987.976979391@ocs3.ocs-net>
Content-Type: multipart/mixed;
 boundary="------------BC952409A8789C82CC1074A8"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------BC952409A8789C82CC1074A8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Keith Owens wrote:
> 
> On Sat, 16 Dec 2000 16:00:51 +0100,
> Martin Michlmayr <tbm@cyrius.com> wrote:
> >ksymoops 2.3.5 on i586 2.2.15.  Options used
> >     -a mipsel
> >Using defaults from ksymoops -t elf32-i386
> 
> The joys of cross system debugging.  You need to set ksymoops option
> -t, it is defaulting to elf32-i386 which is no good for mips objects.
> You almost certainly need to set environment variables KSYMOOPS_NM and
> KSYMOOPS_OBJDUMP to point to versions of these programs that understand
> mips.  If mips prints the code in big endian format then you need to
> use ksymoops option -e.  man ksymoops and scan for 'cross'.

Martin,

If you have System.map file, you can use a perl script written by Phil to
decode the trace.

Jun
--------------BC952409A8789C82CC1074A8
Content-Type: text/plain; charset=us-ascii;
 name="call2sym"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="call2sym"

#!/usr/bin/perl

# call2sym -  convert linux kernel oops call trace listings to System.map
#             symbolic names.
#
# Written by Phil Hollenback
# Copyright (C) 2000 Phil Hollenback <phollenback@pobox.com>
#
# This software may be used and distributed according to the terms
# of the GNU General Public License, incorporated herein by reference.
# All other rights reserved.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# See the perlpod documentation at the end of this file for
# instructions.
#
# $Id: call2sym,v 1.2 2000/09/28 20:15:59 phil Exp $

#
# Configuration Options
#

# This will be viewable thru the "-v" switch at a later date.
$version = "0.0.1";

#
# End Configuration Options
#

# Check that we got passed a System.map file on the command line.
(scalar(@ARGV) == 1) or $mapfile = "System.map";
(scalar(@ARGV) == 1) and $mapfile = $ARGV[0];

( -r $mapfile ) or die "Can't read file $mapfile\n";

print "Ready for call trace list.  <ctrl-d> on a blank line when done.\n\n";

while (<STDIN>)
  {
    # remove newlines in case this was a cut-n-paste.
    chop;
    $trace_line .= $_;
  }

print "\nProcessing...\n";

# Now munge call trace entries into an array.
@trace_addrs = ();

# Split into an array of addresses, on whitespace.
@trace_addrs = split / /,$trace_line;

# I think I'm clever, so use a map to remove cruft from each array
# entry.
@trace_addrs = map { m|\[<(.*)>\]| } @trace_addrs;

# I now have an in-order array of the call trace addresses.

# Suck the whole mapfile into a hash keyed on address.  Convert keys to
# decimal for easier compares later on.
open MAPFILE, $mapfile or die "Can't open mapfile $mapfile\n";
while (<MAPFILE>)
  {
    if ( /^00000000(.*) . (.*)/ )
      {
        # convert to decimal and pad to 10 digits.
        # that way everything lines up and conversions should be easy.
        $decaddr = sprintf "%010lu", hex($1);
        $funcs{$decaddr} = $2;
      }
  }

# print a header
print "\nAddress\t\tFunction\n\n";

# We've got all the addresses in the hash as string versions of
# decimal numbers. Should now be able to iterate thru the
# list until we find the one closest to each $addr.
foreach $addr (@trace_addrs)
  {
    # convert addr to decimal.
    $decaddr = hex($addr);

    # loop through keys until we find the one just 1 greater.
    foreach $func (sort keys %funcs)
      {
        # now print out the one just 1 less.
        if ($func > $decaddr ) {
          print  "$addr\t$funcs{$lastfunc}\n";
          last;
        }
        $lastfunc = $func;
      }
  }




--------------BC952409A8789C82CC1074A8--
