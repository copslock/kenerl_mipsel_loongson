Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA3629298 for <linux-archive@neteng.engr.sgi.com>; Sat, 2 May 1998 16:14:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA19450250
	for linux-list;
	Sat, 2 May 1998 16:08:49 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA19587334
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 2 May 1998 16:08:41 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id QAA19700
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 16:08:38 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA19488
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 May 1998 01:08:36 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA04955;
	Sun, 3 May 1998 01:08:20 +0200
Message-ID: <19980503010816.49649@uni-koblenz.de>
Date: Sun, 3 May 1998 01:08:16 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 updated RPMS for SGI/Linux
References: <Pine.LNX.3.95.980502145754.4130B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980502145754.4130B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, May 02, 1998 at 03:12:30PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, May 02, 1998 at 03:12:30PM -0400, Alex deVries wrote:

> The result of a week of rebooting my machine and avoiding kerne problems
> is almost all the appropriate update RedHat 5.0 RPMs being ported.  The
> ones that have changed are:
> 
> May 02  4:00  AdV  Caught up with RedHat updates for 5.0

Could you also mention that on the news page?  People already believe
the project is dead because nobody writes stupid web docs ...

>    ld.so-1.9.5-2.mipseb.rpm

No.

Heavens, I don't know why this thing built at all for you but this package
neither supports MIPS nor is it required.  The program interpreter (aka
dynamic linker) for GNU libc is packaged in GNU libc.  I suggest removing
this package from our source trees.

> The ones I still haven't sorted out are:
> ld.so

See above.

> kaffe

Afaik kaffee is hairy, because writing a MIPS JIT is required.

> smbfs
> util-linux
> mars-nwe
> ppp
> ncpfs

At least some of these will build if you install Linux 2.0 header files
and the X stuff of which tarballs are online.  It's one of the cheats I
never published ...  I'm using the headerfiles of my Cobalt Qube kernel for
this purpose.  They should have newer kernel source rpms on ftp by now, I
think.

> Now, all of this should eventually be sorted out, and I haven't looked
> through Alan's entire source patches. Most of the work in all of this is
> actually organizing things.
> 
> Please, if you modify the contents of the RPMs directory on linus, keep
> the log in README.txt.

Definately, the current documentation is pretty much (censored).

  Ralf
