Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 22:22:47 +0000 (GMT)
Received: from SMTP6.andrew.cmu.edu ([IPv6:::ffff:128.2.10.86]:5546 "EHLO
	smtp6.andrew.cmu.edu") by linux-mips.org with ESMTP
	id <S8225197AbTBRWWq>; Tue, 18 Feb 2003 22:22:46 +0000
Received: from XYZZY.WV.CC.cmu.edu (XYZZY.WV.CC.cmu.edu [128.2.72.36])
	by smtp6.andrew.cmu.edu (8.12.3.Beta2/8.12.3.Beta2) with ESMTP id h1IMMgQ9002329;
	Tue, 18 Feb 2003 17:22:42 -0500
Subject: Re: Exec from Memory
From: Justin Carlson <justinca@cs.cmu.edu>
To: turcotte@broadcom.com
Cc: linux-mips@linux-mips.org
In-Reply-To: <NDBBKEAAOJECIDBJKLIHCEOGCHAA.turcotte@broadcom.com>
References: <NDBBKEAAOJECIDBJKLIHCEOGCHAA.turcotte@broadcom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Feb 2003 17:22:29 -0500
Message-Id: <1045606950.1164.294.camel@PISTON.AHS.RI.CMU.EDU>
Mime-Version: 1.0
Return-Path: <justinca@cs.cmu.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinca@cs.cmu.edu
Precedence: bulk
X-list: linux-mips

On Tue, 2003-02-18 at 17:08, Maurice Turcotte wrote:
> Greetings:
> 
> I have a hypothetical linux-mips question posed by a colleage.
> 
> Suppose there is no file system available, since there is no disk. And
> suppose that I had the capability to place an elf file in a known location
> in memory. How would I execute it? It seems like exec really wants a file
> name. BTW, this needs to run in use space, not kernel.
> 

There's no easy way (that know of) around the filesystem abstraction. 
You're going to have to deal with it in some manner.  Really basic
stuff, like the elf loader, depends on vfs abstractions.  While it's
possible to bypass all that, it would be a *lot* of work, and a lot of
nearly-duplicated code.

I can see a couple of options.  Other people might have better
suggestions.  :)

1) Use the embedded root ramdisk functionality in the kernel.  Make your
elf file /sbin/init, and run with it.

2) Hack a quick filesystem that uses a contiguous chunk of memory that
you either hardcode or pass in on the kernel command line.

-Justin
