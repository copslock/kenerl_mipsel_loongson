Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id EAA223320 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 04:42:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA02650 for linux-list; Thu, 4 Dec 1997 04:35:27 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA02640 for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 04:35:10 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA24446
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 04:35:00 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-19.uni-koblenz.de [141.26.249.19])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id NAA04683
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 13:34:58 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id LAA27439;
	Thu, 4 Dec 1997 11:43:48 +0100
Message-ID: <19971204114348.10823@uni-koblenz.de>
Date: Thu, 4 Dec 1997 11:43:48 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>, rpm-list@redhat.com
Subject: Re: A question about architecture and byte order with RPMs
References: <Pine.LNX.3.95.971204003012.3395M-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.95.971204003012.3395M-100000@lager.engsoc.carleton.ca>; from Alex deVries on Thu, Dec 04, 1997 at 12:31:05AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 04, 1997 at 12:31:05AM -0500, Alex deVries wrote:

> Below is a message I sent off to the RPM development mailing list. The
> folks at RedHat said it was reasonable, but I just wanted to be sure that
> I got it right. Many of you understand MIPS architectures better than I,
> and we don't want to be making a mistake.
> 
> Is the creation of a mipsel type reasonable?

Definately, only the fact that there are more important things to do did
so far keep me from doing so.

> ---------- Forwarded message ----------
> Date: Tue, 2 Dec 1997 11:34:54 -0500 (EST)
> From: Alex deVries <adevries@engsoc.carleton.ca>
> To: RPM-List <rpm-list@redhat.com>
> Subject: A question about architecture and byte order.
> 
> 
> I *think* there might be an issue with MIPS architecture RPMs, but I want
> to make sure I get things right.
> 
> There are two branches of machines that have MIPS processors.  The first
> is little endian, and it contains things like Acer Pica and Mips Magnum.
> The second is big endian, and has things like my SGI Indy[1]. I'm unclear
> if there are some architectures that will run both.

While almost all MIPS CPUs can run in both byteorder some systems like
the Acer Pica or DECstations don't support this CPU feature.  There is
still another CPU feature that allows to run the other flavor of software
in usermode but supporting it not a Sunday afternoon hack.  It requires
going through _all_ the kernel code and possibly fixing the byteorder
handling.

> Now, the issue is that there aren't distinct architecture definitions for
> mips (big endian) and mipsel (little endian). They aren't binary
> compatible, so it does seem to me that there should be an entry like:

> arch_canon:	mipsel:	mipsel	11
> 
> in rpmrc. 
> 
> Am I wrong on this?

Unless the rpm gurus think there is a better way to do things - yes, it
looks right to me.  The other thing that needs to be done is to teach
rpm how to recognice the various system flavours.  Currently rpm relies
on uname() returning "mips" and therefore thinks MIPS is always MIPS.

Have to take a look at the rpm sources - is there an official way to
teach rpm about incompatible variants of the same CPU architecture?

Modifying uname() to return "mipsel" etc. is a bad choice.  For most
software it is more important to know the CPU architecture than certain
specialised details like the byteorder.  So returning "mipsel" would
break a hell lot of software.

  Ralf
