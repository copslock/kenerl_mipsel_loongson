Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA534200 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Nov 1997 05:58:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA08512 for linux-list; Fri, 28 Nov 1997 05:54:29 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA08505 for <linux@cthulhu.engr.sgi.com>; Fri, 28 Nov 1997 05:54:19 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA20835
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Nov 1997 05:54:17 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id OAA12103;
	Fri, 28 Nov 1997 14:54:14 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id OAA12843; Fri, 28 Nov 1997 14:54:12 +0100
Message-ID: <19971128145410.36065@thoma.uni-koblenz.de>
Date: Fri, 28 Nov 1997 14:54:11 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: Bintuils
References: <19971128004706.49234@uni-koblenz.de> <m0xbQZf-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <m0xbQZf-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Fri, Nov 28, 1997 at 01:35:14PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Nov 28, 1997 at 01:35:14PM +0000, Alan Cox wrote:

> 	Has anyone attempted to build the binutils fixed RPM with the old
> buggy binutils. Im trying this right now and Im getting

> Im now off to rebuild it from scratch with the static new linker to see what
> occurs

I just checked the binutils on my (Intel ...) laptop.  Libbfd contains
DT_NEEDED entries for libc.so.6.  This means that libbfd was linked
against libc which will make binutils 2.7 produce bad executables.

Suggested bootstrap procedure:

  - restore your old binutils 2.7 binaries
  - manually rebuild binutils 2.8.1 + patch.  When configuring binutils
    2.8.1 do not use the --enable-shared option, it will make binutils
    2.7 generate bad libraries.
  - install the binutils just built
  - You should now be able to rebuild the rpm without problems

  Ralf
