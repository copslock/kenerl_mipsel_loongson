Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA52395; Fri, 15 Aug 1997 10:18:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA04419 for linux-list; Fri, 15 Aug 1997 10:18:17 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA04388; Fri, 15 Aug 1997 10:18:14 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA12990; Fri, 15 Aug 1997 10:18:04 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id TAA19277; Fri, 15 Aug 1997 19:17:58 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708151717.TAA19277@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA05781; Fri, 15 Aug 1997 19:17:57 +0200
Subject: Re: Local disk boot HOWTO
To: greg@xtp.engr.sgi.com (Greg Chesson)
Date: Fri, 15 Aug 1997 19:17:56 +0200 (MET DST)
Cc: eak@detroit.sgi.com, shaver@neon.ingenia.ca, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <9708150958.ZM1050@xtp.engr.sgi.com> from "Greg Chesson" at Aug 15, 97 09:58:08 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> On Aug 15,  9:38am, Eric Kimminau wrote:
> > Subject: Re: Local disk boot HOWTO
> 
> > > Do you have a root-mountable filesystem on the second disk?
> > > If so:
> > > - put vmlinux on the IRIX /
> > > - boot into sash
> > > boot /vmlinux root=/dev/sdb1

The receipe is correct.

> seems to me you'd have to also patch vmlinux to get the device ID
> correct for the root disk.  On Irix you'd have to move /dev/root.
> I'm not sure what the equivalent might be on linux.... but I'd like
> to know what the recipe is.  I too would like to bring linux up on
> a secondary disk.

My suggestion is to attack the ext2fs disk to a Linux/i386 machine,
build the root filesystem etc. on it, then back on the Indy use it
for booting.  Linux is so smart that it handles the MSDOG partitions
on the disk created that way correctly and I store my kernel on the
IRIX / anyway.

  Ralf
