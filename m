Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA89773 for <linux-archive@neteng.engr.sgi.com>; Thu, 9 Jul 1998 06:40:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA55017
	for linux-list;
	Thu, 9 Jul 1998 06:40:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA81500
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Jul 1998 06:40:00 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA24761
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Jul 1998 06:39:23 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id PAA03362;
	Thu, 9 Jul 1998 15:39:22 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id PAA28602; Thu, 9 Jul 1998 15:39:20 +0200
Message-ID: <19980709153920.50904@uni-koblenz.de>
Date: Thu, 9 Jul 1998 15:39:20 +0200
From: ralf@uni-koblenz.de
To: Honza Pazdziora <adelton@informatics.muni.cz>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Lmbench for RH 5.1
References: <19980624090439.B1937@w3.org> <199807091317.PAA02524@aisa.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199807091317.PAA02524@aisa.fi.muni.cz>; from Honza Pazdziora on Thu, Jul 09, 1998 at 03:17:22PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jul 09, 1998 at 03:17:22PM +0200, Honza Pazdziora wrote:

> I wanted to do benchmarks on my Indy. The versions 1.0 and 1.1 fail
> when compiling lat_ctx.c with assembler messages:
> Error: Branch out of range on lines 4189 and 40323. When I try to

This is a GAS problem, I doesn't know how to express branches beyond the
16 bit range of a branch instruction as machine instructions.  Newer
lmbench versions don't run into that GAS problem anymore.

> compile it with -O2, it starts optimizing but doesn't seem to finish.

Don't optimize lmbench, the compiler might decide to just throw parts
of lmbench away producing awsome results.  lat_ctx optimized with -O2
hits GCC on one of it's weak points, it will finish to optimize but
will need very long.

> The version 2beta6 of lmbench complains about missing
> linux/autoconf.h.

You probably ran make distclean on the kernel source tree?  Don't, best
leave the kernel source tree configured around, so just use make clean.

The question what is trying to use autoconf.h for what reason remains;
user code isn't supposed to use this file.

(Alex: the kernel source rpm should be installed configured, especially
including autoconf.h for compatibility.)

> This is RH 5.1 Alpha 1 installer with Alpha 2 RPM's placed over the
> Alpha 1 ones, with gcc from redhat-5.0 (Alex, we should put gcc
> to the distribution). Do you have any idea what to do with any
> of these problems? Or do you have precompiled lmbench somewhere?

No, because lmbench normally builds just out of the box.

(The networking code for the kernel which is going to ship with RH
has a couple of crude fixed due to lack of time, don't benchmark to
hard ...)

  Ralf
