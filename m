Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA1425221 for <linux-archive@neteng.engr.sgi.com>; Tue, 24 Mar 1998 19:28:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id TAA3350615
	for linux-list;
	Tue, 24 Mar 1998 19:28:06 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA3403015
	for <linux@engr.sgi.com>;
	Tue, 24 Mar 1998 19:28:04 -0800 (PST)
Received: from informatik.uni-koblenz.de ([141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id TAA01069
	for <linux@engr.sgi.com>; Tue, 24 Mar 1998 19:27:59 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id EAA08802
	for <linux@engr.sgi.com>; Wed, 25 Mar 1998 04:27:56 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA13169;
	Wed, 25 Mar 1998 04:27:42 +0100
Message-ID: <19980325042742.20917@uni-koblenz.de>
Date: Wed, 25 Mar 1998 04:27:42 +0100
To: David A Willmore <willmore@cig.mot.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: MIPS 2.1.89 now in CVS
References: <19980317234843.10411@uni-koblenz.de> <9803242106.ZM28226@whelk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <9803242106.ZM28226@whelk>; from David A Willmore on Tue, Mar 24, 1998 at 09:06:06PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 24, 1998 at 09:06:06PM -0600, David A Willmore wrote:

> > I've upgraded the MIPS port to 2.1.89.  Aside of the still unresolved
> > problem in exit_mm() which I've reported some hours ago is seems to be
> > working on Indys.  Haven't yet tested the rest of my hardware collection.
> >
> > I'm particularly interested in reports about the NCR53C9x driver on
> > Olivetti M700 / Magnum 4000.
> 
> Hey! :)  I've got a 53c90 card for the ISA bus that I would like to use on a
> x86 machine.  Any idea how easy it would be to modify this driver to work with
> a very generic card like that?  Funny that I didn't find any of this code in
> the normal 2.1.90.  I take it your code isn't merged in?

Actually adding the necessary changes shouldn't be difficult.  Check out
the files drivers/scsi/{sparc,jazz}esp.[ch] in one of the snapshots on
ftp.linux.sgi.com.  You'll have to provide a similar machine / bus specific
backend like for these two architectures.  Actually an ISA specific backend
should be easier to implement than these two.

You're right, things have not been merged back but I intend to do this in
the near future.  I just wanted to do some bug bashing in the MIPS kernel.
Things are looking _better_ than ever now, so the time his near.

I just hope penguin central doesn't release 2.2.0 before I do my mergeback ...

(The world will be safe from me for today, I'm going to the CeBIT ...)

  Ralf
