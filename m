Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA19307; Wed, 4 Jun 1997 07:48:54 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA20738 for linux-list; Wed, 4 Jun 1997 07:48:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA20706 for <linux@relay.engr.SGI.COM>; Wed, 4 Jun 1997 07:48:30 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA23157
	for <linux@relay.engr.SGI.COM>; Wed, 4 Jun 1997 07:48:25 -0700
	env-from (ralf@Julia.DE)
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id PAA15362;
	Wed, 4 Jun 1997 15:42:19 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id QAA14054; Wed, 4 Jun 1997 16:40:19 +0200
Message-Id: <199706041440.QAA14054@kernel.panic.julia.de>
Subject: Re: The Plan For Userland(tm)
To: irish@akira.tampa.sgi.com (Liam Irish)
Date: Wed, 4 Jun 1997 16:40:19 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <9706041004.ZM2604@akira.tampa.sgi.com> from "Liam Irish" at Jun 4, 97 10:04:56 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > Yeah, and if there won't be xfs for linux I'd really like to see ext2
> > support for IRIX ...
> 
> >   Ralf
> >-- End of excerpt from Ralf Baechle
> 
> 
> I'd like to do that.  I've already been talking to some engineers about it.  I
> was trying to determine if it already been done.  Guess not.  I think it'd be
> easier to put ext2 on irix than xfs on linux, esp considering the other options
> involved with xfs.  Would it be 32-bit xfs?
> 
> Anyway.  They both interface a VFS, so it should be _too_ bad.  Unfortunately,
> I haven't seen to much documentation for VFS on irix.  Well, see if the Mtn
> View engineers will help out in that regard.

The other fun thing is that right now David and some other people are
rewriting the Linux VFS which also has impact on the ext2 code.

  Ralf
