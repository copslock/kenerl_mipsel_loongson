Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA103248 for <linux-archive@neteng.engr.sgi.com>; Mon, 11 May 1998 01:19:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA23172026
	for linux-list;
	Mon, 11 May 1998 01:18:30 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA23249812
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 11 May 1998 01:18:28 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id BAA12132
	for <linux@cthulhu.engr.sgi.com>; Mon, 11 May 1998 01:18:26 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-01.uni-koblenz.de [141.26.249.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id KAA25547
	for <linux@cthulhu.engr.sgi.com>; Mon, 11 May 1998 10:17:57 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id JAA01311;
	Mon, 11 May 1998 09:33:15 +0200
Message-ID: <19980511093314.12884@uni-koblenz.de>
Date: Mon, 11 May 1998 09:33:14 +0200
To: eak@detroit.sgi.com
Cc: mdhill@interlog.com, linux@cthulhu.engr.sgi.com
Subject: Re: Evidence of Drive Activity to Report
References: <13652.59663.188834.236218@mdhill.interlog.com> <13653.59491.302730.251578@mdhill.interlog.com> <35566E3B.109CCAA3@detroit.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <35566E3B.109CCAA3@detroit.sgi.com>; from Eric Kimminau on Sun, May 10, 1998 at 11:19:23PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, May 10, 1998 at 11:19:23PM -0400, Eric Kimminau wrote:

> I had the exact same problem - I needed to re-make the ext2fs
> filesystem on the drive and re-perform the install for it to get
> further.
> 
> Eric.
> 
> 
> Michael Hill wrote:
> > 
> > Okay, let's say it was just fsck that got hung up, and not the entire
> > boot process.  When it stops with '[/sbin/fsck.ext2] fsck.ext2 -a /'
> > and I press Ctrl-C, more information comes to light:
> > 
> > The superblock could not be read or does not describe a correct ext2
> > filesystem.  If the device is valid and it really contains an ext2
> > filesystem (and not swap or ufs or something else, the the superblock
> > is corrupt, and you might try running e2fsck with an alternate superblock:
> >     e2fsck -b 8193 <device>
> > *** An error occurred during the file system check.
> > *** Dropping you to a shell; the system will reboot
> > *** when you leave the shell.
> > Give root password for maintenance.
> > INIT: entering runlevel: 0mal startup):
> > while opening UTMP file: No such file or directory
> > 
> > ...then I get the SGI maintenance screen back.  There's no evidence of
> > a shell when it tells me it's dropping me to a shell.  From IRIX I ran
> > 'e2fsck -b 8193 drive' on the drive (with no improvement) but I don't
> > think that's the appropriate context.  Suggestions?

Both cases sound like a bad /etc/fstab.  Try adding init=/bin/sh to your
firmware command like arguments.  You'll get a completly uninitialized
system.   Run e2fsck, then you should be able to remount / rw and fix
the fstab.

>         Copyright 1998, Silicon Graphics Computer Systems
>         Confidential to Silicon Graphics Computer Systems
>                 ** -- not for redistribution -- **

And that in a .sig.  ROTFL.  But at least Amy Postnews would love such a
sig :-)

  Ralf
