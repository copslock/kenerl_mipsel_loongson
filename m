Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA257173 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 12:47:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA15438099
	for linux-list;
	Thu, 7 May 1998 12:46:16 -0700 (PDT)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA21129529;
	Thu, 7 May 1998 12:46:13 -0700 (PDT)
Received: (from ariel@localhost) by oz.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA15314; Thu, 7 May 1998 12:46:13 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199805071946.MAA15314@oz.engr.sgi.com>
Subject: [fwd bounced] Re: errors
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Thu, 7 May 1998 12:46:13 -0700 (PDT)
Cc: davem@dm.cobaltmicro.com
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This important email came from David Miller.

It bounced since david apparently changed email addresses
(David, you are subscribed as:
	davem@caip.rutgers.edu
 rather than:
	davem@cobaltmicro.com

 You may unsub/resub yourself to fix it, it is open)

Anyway, here it is, so the list can see it:


----- Forwarded message from owner-linux@cthulhu -----

From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: ralf@uni-koblenz.de
CC: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
In-reply-to: <19980507192145.65233@uni-koblenz.de> (ralf@uni-koblenz.de)
Subject: Re: errors...
References: <Pine.LNX.3.95.980507112045.20653B-100000@lager.engsoc.carleton.ca> <19980507175205.27567@uni-koblenz.de> <199805071609.JAA02646@dm.cobaltmicro.com> <19980507192145.65233@uni-koblenz.de>

   Date: Thu, 7 May 1998 19:21:45 +0200
   From: ralf@uni-koblenz.de

   I've just taken a look at the sources and found that the various
   architectures seem to handle this issue differently by default.
   Sparc disables the exceptions, Intel enables all IEEE754
   exceptions, MIPS only division by zero and overflow and Alpha
   handles things a bit different anyway ...

   Seems there still is no common dominator on what should be default
   and I don't think either 0x00000600 or 0x0 is clearly right or
   wrong.

Log into an IRIX machine, compile a program that prints out the FPU
csr value you see handed to you in main(), 'nuff said, it's zero, and
this is what I did.  All the weird FPU exceptions go away and everyone
is happy.

Later,
David S. Miller
davem@dm.cobaltmicro.com

----- End of forwarded message from owner-linux@cthulhu -----

-- 
Peace, Ariel
