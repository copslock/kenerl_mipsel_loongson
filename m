Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA2670121 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 09:30:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id JAA6939122
	for linux-list;
	Thu, 2 Apr 1998 09:30:13 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA6972765
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 09:30:11 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id JAA02714
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 09:30:09 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-01.uni-koblenz.de [141.26.249.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id TAA27107
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 19:30:06 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA00671;
	Thu, 2 Apr 1998 19:29:50 +0200
Message-ID: <19980402192949.04389@uni-koblenz.de>
Date: Thu, 2 Apr 1998 19:29:49 +0200
To: Ulf Carlsson <grimsy@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: kernel panic
References: <199804021731.TAA00404@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804021731.TAA00404@calypso.saturn>; from Ulf Carlsson on Thu, Apr 02, 1998 at 07:31:00PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 02, 1998 at 07:31:00PM +0200, Ulf Carlsson wrote:

> IP-Config: Got BOOTP answer from 192.168.0.1, my address is 192.168.0.3
> Partition check:
>  sda: sda1 sda2 sda3 sda4
>  sdb: sdb1 sdb2 sdb3
> VFS: Mounted root (ext2 filesystem) readonly.
> Warning: unable to open an initial console.
> Got vced at 8801a2a4.
> Kernel panic: Caught VCE exception - should not happen
> 
> That's the end of it.. tell me if you need some info above those lines..
> Can it be my partition which is screwed? I reinstalled sgi-linux two days ago...

No.  Your report indicates that my last two fixes seem to work.
Now we've got problem #3 in the MC/SC support to fix and I think I've got
an idea what's wrong.  Again I'll go for an simple fix because I don't have
SC CPUs at hand but we're definately on the right way.

  Ralf
