Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA715654 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 May 1998 04:03:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA44544
	for linux-list;
	Mon, 18 May 1998 04:02:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA46977
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 May 1998 04:02:16 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id EAA29010
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 May 1998 04:02:11 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id NAA28512;
	Mon, 18 May 1998 13:02:10 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id NAA26299; Mon, 18 May 1998 13:02:09 +0200
Message-ID: <19980518130208.59609@uni-koblenz.de>
Date: Mon, 18 May 1998 13:02:08 +0200
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grimsy@zigzegv.ml.org>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: VCE exception
References: <Pine.LNX.3.96.980517122752.16103B-100000@web.aec.at> <Pine.LNX.3.96.980518114812.5194B-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.96.980518114812.5194B-100000@calypso.saturn>; from Ulf Carlsson on Mon, May 18, 1998 at 11:54:34AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, May 18, 1998 at 11:54:34AM +0200, Ulf Carlsson wrote:

> I know that this bug is reported, but it's quite annoying (it makes my
> Indy R4000 useless).
> 
> I'm now trying to boot 2.1.99.
> 
> ...
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernes memory: 32k freed
> Warning: unable to open an initial console.
> Got vced at 88018c54.
> Kernel panic: Caught VCE exception - should not happen
> 
> *sigh*

I'm working on a clean solution for the problem which is matching the
virtual and physical colour of pages.  Implementing this is nontrivial
due to the buddy algorithem which Linux uses to maintain it's free
page pool.  I have some solution using DaveM's first approach to the
virtual aliasing problem (it hits Sparcs, too) but that one proofed to
be problematic because it needs to allocate multiple adjacent pages.
In the Ultra case it's just two pages but for R4x00SC/MC it's eigth
pages which essentially turns the machine into a swapping something,
so something smarter is needed unless you have infinite amounts of
RAM ...

  Ralf
