Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA227976 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 10:24:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA21225654
	for linux-list;
	Thu, 7 May 1998 10:22:05 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA17232911
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 7 May 1998 10:22:03 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id KAA19276
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 10:21:59 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id TAA00541;
	Thu, 7 May 1998 19:21:49 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id TAA23907; Thu, 7 May 1998 19:21:46 +0200
Message-ID: <19980507192145.65233@uni-koblenz.de>
Date: Thu, 7 May 1998 19:21:45 +0200
From: ralf@uni-koblenz.de
To: "David S. Miller" <davem@dm.cobaltmicro.com>
Cc: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
Subject: Re: errors...
References: <Pine.LNX.3.95.980507112045.20653B-100000@lager.engsoc.carleton.ca> <19980507175205.27567@uni-koblenz.de> <199805071609.JAA02646@dm.cobaltmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199805071609.JAA02646@dm.cobaltmicro.com>; from David S. Miller on Thu, May 07, 1998 at 09:09:46AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, May 07, 1998 at 09:09:46AM -0700, David S. Miller wrote:

> Ralf did you fix GLIBC to init the FPU csr correctly?  It should be
> set to zero, and the code we had originally did not do this, it set it
> to a bunch of values which induced traps for operations where they
> shouldn't by default.  I fixed this in the Cobalt glibc tree a long
> time ago and we have no FPU emulator code in the kernel.

I've just taken a look at the sources and found that the various
architectures seem to handle this issue differently by default.
Sparc disables the exceptions, Intel enables all IEEE754 exceptions,
MIPS only division by zero and overflow and Alpha handles things a bit
different anyway ...

Seems there still is no common dominator on what should be default and
I don't think either 0x00000600 or 0x0 is clearly right or wrong.

Ok, without the kernel fp stuff zero is somewhat better, so I'm going
to use it.  From the kernel side new born processes default to $fcr31=0
already.  Whatever, this smells like making a kludge just a little bit
better ...

  Ralf
