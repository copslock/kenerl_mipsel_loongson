Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA476413; Thu, 24 Jul 1997 10:43:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA26695 for linux-list; Thu, 24 Jul 1997 10:42:55 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA26657 for <linux@cthulhu.engr.sgi.com>; Thu, 24 Jul 1997 10:42:52 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA26102 for linux@engr.sgi.com; Thu, 24 Jul 1997 10:42:52 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199707241742.KAA26102@oz.engr.sgi.com>
Subject: one more Indy running Linux
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Thu, 24 Jul 1997 10:42:51 -0700 (PDT)
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

Mark Salter just joined the list.  I hope that having Linux
run on an Indy will soon be very common.  At this point it is
rare enough to be worth posting.

What is nice about this case is that Mark just grabbed whatever
we have on the ftp site currently (which is not yet ready) and
without being involved before, managed to get it to run in short order.

Whoever can fix this: Please note the hiccups and problems in
the process.  Maybe we should just update the precompiled binaries
we give to people :-)


----- Forwarded message from Mark Salter -----

>From marks@sun470.rd.qms.com  Thu Jul 24 08:20:01 1997
Date: Thu, 24 Jul 1997 10:19:50 -0500
Message-Id: <199707241519.KAA16443@speedy.qms.com.rd.qms.com>
From: Mark Salter <marks@sun470.rd.qms.com>
To: ariel@sgi.com
Cc: lm@cthulhu, davem@jenolan.rutgers.edu
In-Reply-To: <9707178691.AA869165377@internet-mail.it.qms.com> (ariel@sgi.com)
Subject: Re: [marks@sun470.rd.qms.com: mips linux]


[ pointers deleted ]

Thanks for the pointers, guys. I had relatively little trouble booting
linux on my Indy. I put the "root-be-0.00.cpio.gz" filesystem on my
PPro linux machine and built the kernel from the sources there. The
only problems were:

  * The ".previous" bug in the crossdev binutils binary. This problem got
    some mention in the mailing list, but no resolution was mentioned. I
    got the sources and a patch from ftp.linux.sgi.com, rebuilt binutils
    and that fixed that.

  * I wasn't sure how (or if it is even possible) to get  "root=" options
    to the kernel from the Indy ARC PROM, so I changed NFS_ROOT in 
    include/linux/nfs_fs.h to point to the right place where I placed the
    root filesystem.

So, you can now add me to the list of folks with Indys running linux. I
guess I'll start working on fixing up a second disk so I don't have to
boot off the network...

--Mark

----- End of forwarded message from Mark Salter -----

-- 
Peace, Ariel
