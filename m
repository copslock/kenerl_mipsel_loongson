Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA217036 for <linux-archive@neteng.engr.sgi.com>; Sat, 7 Mar 1998 13:36:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA1683345 for linux-list; Sat, 7 Mar 1998 13:35:31 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA1657122 for <linux@cthulhu.engr.sgi.com>; Sat, 7 Mar 1998 13:35:28 -0800 (PST)
Received: from ballyhoo.ml.org ([194.236.80.80]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA11696
	for <linux@cthulhu.engr.sgi.com>; Sat, 7 Mar 1998 13:35:26 -0800 (PST)
	mail_from (grimsy@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.145.16]) by ballyhoo.ml.org
	 with smtp (ident grimsy using rfc1413) id m0yBRDV-000xjYC
	(Debian Smail-3.2 1996-Jul-4 #2); Sat, 7 Mar 1998 22:33:13 +0100 (CET)
Date: Sat, 7 Mar 1998 22:37:30 +0100 (CET)
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
X-Sender: grimsy@calypso.saturn
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: kernel.
In-Reply-To: <19980307005627.46269@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980307223319.5759A-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, 7 Mar 1998 ralf@uni-koblenz.de wrote:

> On Fri, Mar 06, 1998 at 11:49:16PM +0100, Ulf Carlsson wrote:
> 
> > Did someone compile the latest tarball ralf made? Does it work? Is it
> > worth the time it takes to download the xcompiler and the source?
> 
> Of course it is working :-)

Ok, I downloaded the kernel + xcompiler.

It didn't work, got a compile error. I can't fix it because it's the
gloomy azzemblur again.

make[1]: Entering directory
`/home/grimsy/sgi-lin/linux-980304/arch/mips/kernel'mips-linux-gcc
-D__KERNEL__ -I/home/grimsy/sgi-lin/linux-980304/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -pipe -c entry.S -o entry.o
entry.S: Assembler messages:
entry.S:146: Error: .previous without corresponding .section; ignored
entry.S:146: Error: .previous without corresponding .section; ignored
entry.S:147: Error: .previous without corresponding .section; ignored
entry.S:147: Error: .previous without corresponding .section; ignored
entry.S:154: Error: .previous without corresponding .section; ignored
entry.S:154: Error: .previous without corresponding .section; ignored
entry.S:156: Error: .previous without corresponding .section; ignored
entry.S:156: Error: .previous without corresponding .section; ignored
entry.S:157: Error: .previous without corresponding .section; ignored
entry.S:157: Error: .previous without corresponding .section; ignored
entry.S:158: Error: .previous without corresponding .section; ignored
entry.S:158: Error: .previous without corresponding .section; ignored
make[1]: *** [entry.o] Error 1
make[1]: Leaving directory
`/home/grimsy/sgi-lin/linux-980304/arch/mips/kernel'
make: *** [linuxsubdirs] Error 2

Tell me if I should give some other information.

- Ulf
