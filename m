Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA2438049 for <linux-archive@neteng.engr.sgi.com>; Mon, 30 Mar 1998 23:16:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id XAA5834412
	for linux-list;
	Mon, 30 Mar 1998 23:15:22 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA5480028
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 30 Mar 1998 23:15:20 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id XAA04103
	for <linux@cthulhu.engr.sgi.com>; Mon, 30 Mar 1998 23:15:18 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-23.uni-koblenz.de [141.26.249.23])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id JAA16443
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 09:15:16 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id JAA04066;
	Tue, 31 Mar 1998 09:14:52 +0200
Message-ID: <19980331091452.41730@uni-koblenz.de>
Date: Tue, 31 Mar 1998 09:14:52 +0200
To: Ulf Carlsson <grimsy@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
References: <19980330154244.19782@uni-koblenz.de> <Pine.LNX.3.96.980331092426.411B-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980331092426.411B-100000@calypso.saturn>; from Ulf Carlsson on Tue, Mar 31, 1998 at 09:26:20AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 31, 1998 at 09:26:20AM +0200, Ulf Carlsson wrote:

> On Mon, 30 Mar 1998 ralf@uni-koblenz.de wrote:
> 
> > On Mon, Mar 30, 1998 at 09:42:56AM +0200, Oliver Frommel wrote:
> > 
> > > i got the kernel (linux-980326) from linux.sgi.com and had the following
> > > problems crosscompiling it from intel-linux (which appeared on list once, but
> > > without any answer/solution as far as i remember):
> > > 
> > > mips-linux-gcc -D__KERNEL__ -I/mnt/dsk1/devel/mips/linux-980326/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -c entry.S -o entry.o
> > > entry.S: Assembler messages:
> > > entry.S:147: Error: .previous without corresponding .section; ignored
> > > make[1]: *** [entry.o] Error 1
> > > make[1]: Leaving directory `/mnt/dsk1/devel/mips/linux-980326/arch/mips/kernel'
> > > make: *** [linuxsubdirs] Error 2
> > > 
> > > 
> > > i'd appreciate an explanation what's happening here very much ..
> > 
> > In the vanilla FSF sources the .previous pseudo is broken resulting in
> > these messages.  The fix is in 2.7-4 and newer.
> 
> What are the vanilla FSF sources? The only FSF I have knowlegde of is the
> Free Software Foundation :-)

Sorry, but the FSF doesn't over any other flavour except vanilla ;-)

> Do I need a new crosscompiler?

Not really, if you have a native compiler setup.  A crosscompiler is
however very handy and sometimes even necessary when bootstrapping for a
new system.

  Ralf
