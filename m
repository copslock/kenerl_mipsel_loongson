Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA3672084 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 May 1998 05:49:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA19243020
	for linux-list;
	Sun, 3 May 1998 05:48:11 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA19818089
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 3 May 1998 05:48:09 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id FAA13029
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 May 1998 05:48:04 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-29.uni-koblenz.de [141.26.249.29])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA08517
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 May 1998 14:47:59 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id OAA05350;
	Sun, 3 May 1998 14:47:44 +0200
Message-ID: <19980503144744.11223@uni-koblenz.de>
Date: Sun, 3 May 1998 14:47:44 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 updated RPMS for SGI/Linux
References: <19980503010816.49649@uni-koblenz.de> <Pine.LNX.3.95.980502204018.4130E-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980502204018.4130E-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, May 02, 1998 at 08:56:08PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, May 02, 1998 at 08:56:08PM -0400, Alex deVries wrote:

> On Sun, 3 May 1998 ralf@uni-koblenz.de wrote:
> > On Sat, May 02, 1998 at 03:12:30PM -0400, Alex deVries wrote:
> > > May 02  4:00  AdV  Caught up with RedHat updates for 5.0
> > Could you also mention that on the news page?  People already believe
> > the project is dead because nobody writes stupid web docs ...
> 
> Yup, that's done now.
> 
> > >    ld.so-1.9.5-2.mipseb.rpm
> > No.
> > Heavens, I don't know why this thing built at all for you but this package
> > neither supports MIPS nor is it required.  The program interpreter (aka
> 
> It built badly, but it slipped through the cracks and made it into the
> distribution.  I didn't quite know the status of it.  Anyway, this is now
> in the trash.

It actually be changed to prevent it from being building on MIPS and others
which have no use for it.

> > At least some of these will build if you install Linux 2.0 header files
> > and the X stuff of which tarballs are online.  It's one of the cheats I
> > never published ...  I'm using the headerfiles of my Cobalt Qube kernel for
> > this purpose.  They should have newer kernel source rpms on ftp by now, I
> > think.
> 
> util-linux definitely needs some fixing, it is such a badly written
> package.  The others were things like errors with FD_ZERO and others,
> clearly with header files being, er, different than on i386.

Linux 2.0 headers help somewhat.

> This brings up the issue of getting all the kernel fixes back into the
> main stream kernel _before_ 2.2 so that things get synched up right.

Include/asm-mips, drivers/scsi/sgiwd93.[ch], drivers/net/sgiseeq.[ch],
arch/mips/ are in sync with vger-cvs, from where they'll go to Linus.
I've got some more hacks on hold.  Once they're commited, I won't have
time for some days, then I'll start upgrading the thing to linus-current.
Will have to redo some things, one of my disks has thrown the spoon ...

> There's a large amount of comfort for this project to stick with what The
> Big Guys (RedHat) are releasing.
>                                   Of course we don't know that they'll be
> moving to 2.2 when it comes out, but 2.0 is useless for us and 2.1 seems
> less likely.  Of course, all this is just guess work, since intelligently
> people are avoiding vapourware.  I doubt there's even been an announcement
> of Red Hat distributing a 5.1...
> 
> In #linux, Alan said that Ralf and DaveM were working on this merge.  I
> know that Mike Shaver said he was interested.  All I can say is that I
> probably don't have time for it.
> 
> Also, for the mipsel packagers out there, could you kindly now use RPM
> 2.4.109?

Does this mean that the mipsel/mipseb modifications are now distributed with
RedHat's sources?

>           There's a source RPM on linus for this. It generates a different
> architecture of the packages.  If I had a mipsel machine, I'd do it,
> but...

I have several le machines.

> > Definately, the current documentation is pretty much (censored).
> 
> Yup.  Oh, god, doing the actual work is so much more fun than updating WWW
> pages... *sigh*.

Agreed, but it has to be done.  I'm myself a web hater ...

  Ralf
