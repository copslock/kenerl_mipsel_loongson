Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA242516 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 09:12:35 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA18198 for linux-list; Thu, 4 Dec 1997 09:07:34 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA18106 for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 09:07:21 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA27808
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 09:07:17 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA14340;
	Thu, 4 Dec 1997 12:04:37 -0500
Date: Thu, 4 Dec 1997 12:04:36 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>, rpm-list@redhat.com
Subject: Re: A question about architecture and byte order with RPMs
In-Reply-To: <19971204114348.10823@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.971204114636.10196F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 4 Dec 1997 ralf@uni-koblenz.de wrote:
> On Thu, Dec 04, 1997 at 12:31:05AM -0500, Alex deVries wrote:
> > Is the creation of a mipsel type reasonable?
> Definately, only the fact that there are more important things to do did
> so far keep me from doing so.

> While almost all MIPS CPUs can run in both byteorder some systems like
> the Acer Pica or DECstations don't support this CPU feature.  There is

Right.  So they'd be of arch 'mips'.

> still another CPU feature that allows to run the other flavor of software
> in usermode but supporting it not a Sunday afternoon hack.  

Hm.  RPM makes no diffrentiation between user and non-usermode apps.  So,
I'd say we'd mark this as 'mipsbi'.  The only restriction is with kernel
RPMs, and there aren't a lot of those.

> It requires
> going through _all_ the kernel code and possibly fixing the byteorder
> handling.

Nobody wants that.

> Unless the rpm gurus think there is a better way to do things - yes, it
> looks right to me.  The other thing that needs to be done is to teach
> rpm how to recognice the various system flavours.  Currently rpm relies
> on uname() returning "mips" and therefore thinks MIPS is always MIPS.

That shouldn't be too difficult to build into .configure.  For everything
matching mips:*, configure should do a byte order execution check. If it
can do mipsel, it's little endian.  If it can do bigendian, it's mips.  If
it can do both, it's mipsbi.  Is there an easy way to do a test like
this, Ralf?

> Have to take a look at the rpm sources - is there an official way to
> teach rpm about incompatible variants of the same CPU architecture?

Yes, sort of.

There should be two binary formats defined in /usr/lib/rpmrc
arch_canon: mips: mips 4 (already defined)
arch_canon: mipsel: mipsel 11 

Then, 
arch_compat: mips: noarch 
arch_compat: mipsel: noarch 
arch_compat: mipsbi: mips mipsel

> Modifying uname() to return "mipsel" etc. is a bad choice.  For most

I agree.  I think we should just patch the configure script to do a
translation to mips, mipsel or mipsbi, as I described above.

- Alex
