Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA2571669 for <linux-archive@neteng.engr.sgi.com>; Sun, 26 Apr 1998 14:53:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA16905789
	for linux-list;
	Sun, 26 Apr 1998 14:52:43 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA16358399
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 26 Apr 1998 14:52:24 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA12666
	for <linux@cthulhu.engr.sgi.com>; Sun, 26 Apr 1998 14:52:23 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA11133;
	Sun, 26 Apr 1998 17:52:17 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 26 Apr 1998 17:52:16 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Various kernel issues.
In-Reply-To: <19980426140928.63303@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980426173547.9541C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Sun, 26 Apr 1998 ralf@uni-koblenz.de wrote:
> On Sun, Apr 26, 1998 at 12:34:54AM -0400, Alex deVries wrote:
> > Uh, there was nothing at 080f3b5c or nearby, so I'm pretty sure that that
> > was misttyped as 880f3b5c.  Here are both:
> 880f3b5c makes sense.  The bad news is that none of the two routines
> r4k_dma_cache_wback_inv_pc or dma_setup is the culprit.  Something else
> must either have assembled bad SCSI scatter gather lists or corrupted
> them such that a NULL pointer got passed down to dma_cache_wback_inv.
> So no fix obvious.

I'll play around with it a bit and make sure that I get similiar results
when I crash it... Let me know if I can help debug this in any way.

In the meantime, I'm trying to churn out updated RPMs using 2.1.72.  This
is difficult because after being up for about 5 minutes, gcc complains
that it can't create executables because:
- /usr/lib/crt1.o is corrupt or disappeared or
- crtbegin.o is gone like beer at a technical university
- program cc1 got fatal signal 11

Other weird things:
- tcsh doesn't work with .1.91, but it does with .72.  I know, I wouldn't
believe it either.  Sure, go ahead, make fun of my shell.
- my boot sequence with 72 now consists of:
   - unmount sdb1 and sdc cleanly
   - three finger salute
   - boot kernel
   - e2fsck, always errors, wait 20 mins
   - reinstall binutils, gcc and all of glibc RPM, always end up with
     weird problems like:
ls -l /usr/share/zoneinfo/America/Indiana/Knox
crwSrwxr-t   3 19496   10694   77, 161 Dec 22  1956 Knox
     Sure, Knox, Indiana might actually be a character device, but I'm
     doubtful about the date.

I'm > < this close to just NFS mounting everything over from my PC, these
disk problems are driving me nuts. This is all so weird, my life was
peachy before I got started with glibc 2.0.6 and stopped running .72.
Still, it's more stable than NT.

> Grrrr,

Indeed.

And in unrelated news, I'm moving to Toronto in a month.

- alex
