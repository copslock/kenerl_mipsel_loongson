Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id SAA110861 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 18:43:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA05604 for linux-list; Mon, 12 Jan 1998 18:40:15 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA05582 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 18:40:10 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA01308
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 18:40:03 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-22.uni-koblenz.de [141.26.249.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA17214
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 03:40:01 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA02790;
	Tue, 13 Jan 1998 03:36:23 +0100
Message-ID: <19980113033623.32297@uni-koblenz.de>
Date: Tue, 13 Jan 1998 03:36:23 +0100
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "K." <conradp@cse.unsw.edu.au>, linux@cthulhu.engr.sgi.com
Subject: Re: crtbegin.o, crtend.o
References: <Pine.GSO.3.95.980112161052.11350F-100000@l4-00.orchestra.cse.unsw.EDU.AU> <19980112095804.26411@uni-koblenz.de> <19980112195622.35682@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <19980112195622.35682@alpha.franken.de>; from Thomas Bogendoerfer on Mon, Jan 12, 1998 at 07:56:22PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 12, 1998 at 07:56:22PM +0100, Thomas Bogendoerfer wrote:

> > > um... can anyone point out where these files can be obtained? In our
> > > recent install, (Indy R4600) made from the root-be-0.01 root filesystem
> > > with the recent binutils-2.8.1-2, they are missing. We hacked out dummy
> > > object files (crtbegin has a __main() which calls main() and crtend is
> > > empty) and we can successfully compile simple programs; but before we turn
> > > our attention to compiling nastier pieces of code we would like to check
> > > that we have not tainted our /usr/lib :)
> > 
> > Upgrade your system with all the rpm packages.  root-0.01 was my first
> > collection of Indy executables and basically_every_ ELF file has bugs in
> > it ...
> 
> but at least with the little endian gcc rpm you want get crtbegin.o and
> crtend.o, because they are missing. Neither x86, alpha nor sparc have such
> files (at least not in gcc), so they are missing from the redhat .spec file.
> Sorry for the late bug report.

I think we had that topic before.  My rpm gcc-2.7.2-2 dated 971213 fixes
that.  Think I never uploaded it, sigh ...

  Ralf
