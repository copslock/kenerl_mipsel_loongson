Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA22098
	for <pstadt@stud.fh-heilbronn.de>; Thu, 15 Jul 1999 03:24:17 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA5823442; Wed, 14 Jul 1999 18:22:24 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA20787
	for linux-list;
	Wed, 14 Jul 1999 18:19:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA57502
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Jul 1999 18:18:59 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from mail.cobaltnet.com (firewall.cobaltmicro.com [209.133.34.37] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07478
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jul 1999 18:18:58 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from cobaltnet.com (freakshow.cobaltnet.com [10.9.24.15])
	by mail.cobaltnet.com (8.9.3/8.9.3) with ESMTP id SAA23075;
	Wed, 14 Jul 1999 18:16:31 -0700
Message-ID: <378D36E5.CBF85556@cobaltnet.com>
Date: Wed, 14 Jul 1999 18:18:29 -0700
From: Tim Hockin <thockin@cobaltnet.com>
Organization: Cobalt Networks
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>, linux@cthulhu.engr.sgi.com
CC: cjohnson@cobaltnet.com
Subject: Re: Float / Double issues - solved, perhaps
References: <378AADF5.96152E0B@cobaltnet.com> <19990714235346.A1231@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

> On Mon, Jul 12, 1999 at 08:09:41PM -0700, Tim Hockin wrote:
>
> > Hey gang - I have what seems to be two seperate issues on Mips/Linux
> > (cobalt boxes).
> >
> > 1) Programs using doubles with pthreads get corrupted data in the
> > doubles.
>
> That one is funny.  It was/is a longstanding libc bug originally reported
> by Dong Liu.  I actually thought it'd be fixed but now thanks to your
> report I see it's still broken.  So the multithreaded variant of your
> double.c doesn't work at all on our libc.
>
> The bug is in glibc/sysdeps/unix/sysv/linux/mips/clone.S; I suppose
> Cobalt's libc which I last worked on late October is still using my
> old clone.S from that time or somebody else there came up with a funky
> new bug completly on it's own - which might explain why double.c cannot
> even successfully create the threads.

We have the fix, I think.  Not clone.S, but in
glibc-2.0.7/linuxthreads/internals.h line 86 we need to tell gcc that this
struct (_pthread_descr_struct - which defines the offset of a thread's stack
from a well-aligned, malloc() returned addr) be padded to be aligned
correctly on an 8byte boundary:

-};
+} __attribute__ ((aligned(__alignof__(double))));

It's working for us now.  Please confirm if it works for you folks, too.  A
bug report has been filed for glibc, though I doubt if anything official
goes on for 2.0.x, now. Hopefully 2.1.x will fold this in.  A thread's stack
really should always be well aligned :)  Funny, the doubles were actually
calculated right, but stdio functions use va_arg - which expected double's
to be aligned, and weren't.  The work got done, but it couldn't tell us!

As for the va_arg "bug" - I realized it was pilot error shortly after
sending it out.  I just needed to look at something that was NOT this double
bug for a while. :)  So the new question is who wants to do thread support
in gdb !!

Tim
