Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA944291 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Dec 1997 09:08:36 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA12537 for linux-list; Wed, 10 Dec 1997 09:06:08 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA12448 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Dec 1997 09:05:55 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA29810
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Dec 1997 09:05:51 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id SAA14228
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Dec 1997 18:05:25 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id SAA00500;
	Wed, 10 Dec 1997 18:02:29 +0100
Message-ID: <19971210180229.20549@uni-koblenz.de>
Date: Wed, 10 Dec 1997 18:02:29 +0100
To: Takeshi Hakamada <hakamada@meteor.nsg.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Mount ext2 filesystem.
References: <199712101335.WAA09888@meteor.nsg.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199712101335.WAA09888@meteor.nsg.sgi.com>; from Takeshi Hakamada on Wed, Dec 10, 1997 at 10:35:39PM +0900
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Dec 10, 1997 at 10:35:39PM +0900, Takeshi Hakamada wrote:

> I'm working on my R5000 Indy can mount second disk as root filesystem.
> I've created ext2 filesystem from my i486-based Linux box and I connected
> it to my Indy as the second drive. Then I booted vmlinux-indy-2.1.67
> (made by Ralf) from the first disk on my Indy, mounted nfs-root filesystem
> which is made by Ralf I know.
> I can mount both the first disk(efs) and the second one(ext2).
> 
> However, when I try to invoke rpm which is made by Alan(libc/ld workaround
> version), I get efs read error as follows:
> 
> efs: read error in indirect extents
> attempt to access beyond end of device
> 08:01 rw=0, want=1207011792, limit=1965937
> 
> Do you think something wrong with my IRIX efs partition? When I mount
> IRIX root partition, I can invoke some IRIX command(like ls, cp).

The efs filesystem for Linux is completly broken.  If you want to transfer
files from IRIX to Linux I recommend something like NFS or ftp to another
machine.

> Anyway, why root-be-0.00.cpio.gz doesn't contain rpm binary?
> I think rpm binary should be in root-be-0.00.cpio.gz.

The archive was the first collection of binaries ever.  It isn't really
intended to be a real distribution.  Someone else promised to work on
an installation procedure rsn.

  Ralf
