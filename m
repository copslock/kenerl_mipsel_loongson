Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id EAA14697
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 04:56:04 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA03997; Tue, 29 Jun 1999 19:50:13 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA23869
	for linux-list;
	Tue, 29 Jun 1999 19:47:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA75895
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 29 Jun 1999 19:47:04 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup146-1-29.swipnet.se [130.244.146.29]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA08444
	for <linux@cthulhu.engr.sgi.com>; Tue, 29 Jun 1999 19:47:02 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10zAOs-003LoEC; Wed, 30 Jun 1999 04:47:02 +0200 (CEST)
Date: Wed, 30 Jun 1999 04:47:02 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Memory corruption
Message-ID: <19990630044702.A6969@thepuffingroup.com>
Mail-Followup-To: "William J. Earl" <wje@fir.engr.sgi.com>,
	linux@cthulhu.engr.sgi.com
References: <19990622033931.A7201@thepuffingroup.com> <199906300101.SAA09334@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <199906300101.SAA09334@fir.engr.sgi.com>; from William J. Earl on Tue, Jun 29, 1999 at 06:01:47PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>  > The compiler may stop working sometimes on certain files, giving bogus
>  > error messages which I don't understand (the compiler is probably not the
>  > only application affected).  Running this program I just wrote forces the
>  > corrupted caches to be flushed or something and ``fixes'' the problems:
> ...
> 
>       This problem sounds like a cache flushing problem.  Do you also get
>       SIGILL, SIGBUS, and SIGSEGV failures?  One possibility is that the
>       icache is not being flushed on a page fault, when a page is read in from
>       disk, and the icache still has old data in it.  This could lead to a
>       cache line of bogus instructions being executed.

Sometimes when this happens I think I only get a SIGSEGV or a SIGBUS, otherwise
I get internal compiler errors.  It's hard to say since these problems are very
hard to reproduce, and I forget what happens from time to time.  I have
unfortunately not written down the results.  It sounds like this may be the
cause of the type of file corruption I have when only a little part of the file
is damaged (sounds like the problem covers both icache and dcache).  That type
of file corruption goes away after reboot.  I haven't had a chance to try this
with my discard-disk-cache program since this happens very seldom..

>       What model of CPU do you have in your machine?

I have a 133 MHz R4600 with 512kb board cache, 16kb dcache and 16kb icache.

Regards,
Ulf
