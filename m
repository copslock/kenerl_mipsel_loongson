Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA216734 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 08:53:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA16845240
	for linux-list;
	Thu, 7 May 1998 08:52:24 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA12917056
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 7 May 1998 08:52:21 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA08848
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 08:52:18 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id RAA24547;
	Thu, 7 May 1998 17:52:08 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id RAA20258; Thu, 7 May 1998 17:52:05 +0200
Message-ID: <19980507175205.27567@uni-koblenz.de>
Date: Thu, 7 May 1998 17:52:05 +0200
From: ralf@uni-koblenz.de
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: errors...
References: <Pine.LNX.3.95.980507112045.20653B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.980507112045.20653B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Thu, May 07, 1998 at 11:22:58AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, May 07, 1998 at 11:22:58AM -0400, Alex deVries wrote:

> So, I was compiling .99 last night, and my machine hung.  I came in this
> morning, and found reams of errors on the screen, all of which were:
> 
> Setting flush to zero for patch.
> Unimplemented exception at 0x004057f0

Still lacking the kernel math code for MIPS I implemented a cruel hack.
If we catch an unimplemented exception and flush-to-zero is cleared, we
set it and retry the instruction.  If flush-to-zero is already set, the
problem is beyond what we can deal with ...

The only mysterious thing for me is right now why patch is using floating
point.  Whatever, this error message is not directly related to the hang,
it's more telling people that fp results might be inaccurate or wrong.

Anybody with floating point experience and time to write this stuff?
What we need is basically a subset of a coprozessor emulation; there is
example code available in the NetBSD, OpenBSD and MACH MIPS assembler
code; the Sparc64 code is even written in C.

> This is 2.1.91 kernel I got from Ralf.  Maybe this is useless, since I'm
> on my way to running .99 anyway.

I'm interested to hear if .99 hangs again for you.  All I can say is
that I tested .99 by recompiling libc and that crashed ``No space left
on device'', so it must be good ;-)

  Ralf
