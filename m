Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA2430493 for <linux-archive@neteng.engr.sgi.com>; Mon, 30 Mar 1998 22:24:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id WAA5830574
	for linux-list;
	Mon, 30 Mar 1998 22:24:04 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA5825545
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 30 Mar 1998 22:24:02 -0800 (PST)
Received: from ballyhoo.ml.org ([194.236.80.80]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id WAA22962
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Mar 1998 22:23:59 -0800 (PST)
	mail_from (grimsy@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.100.14]) by ballyhoo.ml.org
	 with smtp (ident grimsy using rfc1413) id m0yJuQN-000xjYC
	(Debian Smail-3.2 1996-Jul-4 #2); Tue, 31 Mar 1998 08:21:31 +0200 (CEST)
Date: Tue, 31 Mar 1998 09:26:20 +0200 (CEST)
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
X-Sender: grimsy@calypso.saturn
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
In-Reply-To: <19980330154244.19782@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980331092426.411B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 30 Mar 1998 ralf@uni-koblenz.de wrote:

> On Mon, Mar 30, 1998 at 09:42:56AM +0200, Oliver Frommel wrote:
> 
> > i got the kernel (linux-980326) from linux.sgi.com and had the following
> > problems crosscompiling it from intel-linux (which appeared on list once, but
> > without any answer/solution as far as i remember):
> > 
> > mips-linux-gcc -D__KERNEL__ -I/mnt/dsk1/devel/mips/linux-980326/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -c entry.S -o entry.o
> > entry.S: Assembler messages:
> > entry.S:147: Error: .previous without corresponding .section; ignored
> > make[1]: *** [entry.o] Error 1
> > make[1]: Leaving directory `/mnt/dsk1/devel/mips/linux-980326/arch/mips/kernel'
> > make: *** [linuxsubdirs] Error 2
> > 
> > 
> > i'd appreciate an explanation what's happening here very much ..
> 
> In the vanilla FSF sources the .previous pseudo is broken resulting in
> these messages.  The fix is in 2.7-4 and newer.

What are the vanilla FSF sources? The only FSF I have knowlegde of is the
Free Software Foundation :-)
Do I need a new crosscompiler?

- Ulf
