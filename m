Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA40146 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Oct 1998 16:51:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA25589
	for linux-list;
	Thu, 15 Oct 1998 16:48:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA93035
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Oct 1998 16:48:35 -0700 (PDT)
	mail_from (jcoffin@lil.sv.usweb.com)
Received: from lil.sv.usweb.com ([207.44.155.155]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id QAA07214
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Oct 1998 16:48:32 -0700 (PDT)
	mail_from (jcoffin@lil.sv.usweb.com)
Received: (qmail 10806 invoked by uid 500); 15 Oct 1998 23:46:33 -0000
To: Ulf Carlsson <grim@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
References: <m3ww618s88.fsf@lil.sv.usweb.com> <19981016001717.B2072@zigzegv.ml.org>
From: Jeff Coffin <jcoffin@sv.usweb.com>
Date: 15 Oct 1998 16:46:29 -0700
In-Reply-To: Ulf Carlsson's message of Fri, 16 Oct 1998 00:17:17 +0200
Message-ID: <m3pvbt8k2y.fsf@lil.sv.usweb.com>
X-Mailer: Gnus v5.5/Emacs 20.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson <grim@zigzegv.ml.org> writes:

> It *should* find an initial console if you have mounted the root
> filesystem from the hardhat CD correctly. 

Maybe that's the problem, it all *looks* right.  Is this the case for
the harthat kernel as well as the 2.1.116 and 2.1.121 versions off the
FTP server?

Let's see if I have this straight:

from the PROM, it I do

boot bootp():/vmlinux

and NFS is configured properly (more or less as per the HowTo) on the
i386 box, the kernel will boot and find the NFS root filesystem as
configured in exports or do I need to pass the kernel the nfsroot
param to get it to properly mount the install root?

> It would probably not make much difference, "Warning: unable to open
> an initial console" isn't caused by a gfx board neither an old
> kernel, but from an incorrect /dev/console. 

That's what I thought.  I was speculating that the hardware trouble
was causing the kerel hangs.

> I'm currently running hardhat diskless, I'm only using the IRIX
> harddrive when I boot (the bootp command is loaded from the
> harddrive). 

Not from the PROM?  How does that work?  (I'm new to SGI's and getting
IRIX up at all from just a CD and a new hard drive was a "learning
experience") 

I'll play with it some more tonight or tomorrow when i have the time.

Thanks for the suggestions.


--jeff
