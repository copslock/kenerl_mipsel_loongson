Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NFK7I11314
	for linux-mips-outgoing; Wed, 23 May 2001 08:20:07 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NFK7F11311
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 08:20:07 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 6444EF1A9; Wed, 23 May 2001 08:18:46 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 04A08BBDA; Wed, 23 May 2001 08:19:05 -0700 (PDT)
Date: Wed, 23 May 2001 08:19:05 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: joshua@babbage.millersv.edu
Cc: linux-mips@oss.sgi.com
Subject: Re: porting from headers
Message-ID: <20010523081905.A10516@foobazco.org>
References: <3B0AEC51.B0C477E1@mvista.com> <Pine.LNX.4.21.0105230943440.10519-100000@babbage.millersville.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105230943440.10519-100000@babbage.millersville.edu>; from joshua@babbage.millersv.edu on Wed, May 23, 2001 at 09:45:54AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 23, 2001 at 09:45:54AM -0400, joshua@babbage.millersv.edu wrote:

> The other day on irc.openprojects.net #mipslinux, someone said that the
> initial O2 port was done using the irix header files to glean enough
> hardware info to make the needed changes.  How would this process
> work?  Could someone post examples of how parts of the header files
> indicate how to get something else to boot on the hardware?

Start with common sense: 

1. It's ARCS, so prom_printf and the ARCS memory map work.  2. It's
got an already-supported MIPS CPU.

That's enough if you don't screw it up to get to the having no root
and must scream point.  Then, you look at the headers and see that it
has two 16550 serial ports, and you know their addresses.  Plug those
into the standard peecee serial driver and you have a serial console.
Likewise the RTC.  You look at crime.h and see the CRIME_TIME
mechanism, along with its frequency, and you guess that you can
calibrate your system timer from that.  Now your timers are right.

You want PCI, that's another matter; you can pull out the config space
pointers and read/write the config space rather easily from the
headers, and likewise it gives you the CPU physical addresses for
device BARs.  But nobody will tell you that most of these spaces need
to be swapped... :-)

Basically the headers give you the addresses of registers and
occasionally their formats.  If you're clever you can figure out how
to go from there.  I'm not so clever so it's been something like 8
months I've been fooling with this.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
