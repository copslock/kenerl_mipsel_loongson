Received:  by oss.sgi.com id <S554134AbRA0IBt>;
	Sat, 27 Jan 2001 00:01:49 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:56317 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553819AbRA0IB1>;
	Sat, 27 Jan 2001 00:01:27 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA00034;
	Sat, 27 Jan 2001 09:01:48 +0100 (MET)
Date:   Sat, 27 Jan 2001 09:01:47 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Justin Carlson <carlson@sibyte.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: GDB 5 for mips-linux/Shared library loading with new binutils/glibc
In-Reply-To: <0101261750492Y.00834@plugh.sibyte.com>
Message-ID: <Pine.GSO.3.96.1010127084850.29150E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 26 Jan 2001, Justin Carlson wrote:

> Working with some pretty bleeding edge GNU tools, here, and there doesn't seem
> to be any support for mips-linux in GDB 5.  Has anyone else run across this,
> and, if so, are there patches available somewhere?

 Get gdb 5.0 from my site, at 'ftp://ftp.ds2.pg.gda.pl/pub/macro/'.

 I've contributed all patches I've written myself.  Unfortunately, most of
the code needed for gdb 5.0 to run on MIPS was taken from the 4.x CVS at
oss.sgi.com.  As such it is required all authors of patches have to have
their copyright assigned to FSF before committing them to the gdb CVS.

 I've asked people to resolve ownership of the code here some time ago,
but it seems nobody is really interested in getting this code into
official gdb, sigh... 

> Also, I've run into a problem with ld.so from glibc-2.2 on mips32-linux.  After
> some hunting, I found that the templates in elf32bsmip.sh for gnu ld have
> recently changed to support SHLIB_TEXT_START_ADDR as a (non-zero) base address
> for shared library loading.  SHLIB_TEXT_START_ADDR defaults to 0x5ffe0000 in
> the current sources.

 It's not that recent, actually.  What's the problem with this?  I can't
see any on mipsel-linux here.

> I'm curious if anyone knows the rationale for these changes.  Best conjecture
> I've heard is that it allows ld.so to not have to relocate itself, as it will
> load by default to the high address.  

 Not sure about this -- there are comments on it in glibc in
sysdeps/mips/dl-machine.h.

> However, ld.so seems to know nothing about relocating shared library with a
> non-zero shared library base address, which causes dynamically linked stuff to
> crash spectacularly.  

 Does it?  Please provide more details.  All of my system (linux 2.4.0,
glibc 2.2.1) is dynamically linked and it works fine.

> binutils we're using is from CVS as of about Dec 17th.  Glibc is also a
> snapshot from about the same time.

 Glibc should be fine as is although you might consider getting the 2.2.1
release.  You may try to check if patches from my binutils package (also
available at the mentioned site) solve certain or all of your problems. 
The patches have been proposed for an inclusion in the upcoming binutils
2.11 release -- I hope they will finally get there.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
