Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id EAA357490 for <linux-archive@neteng.engr.sgi.com>; Sat, 24 Jan 1998 04:56:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA18164 for linux-list; Sat, 24 Jan 1998 04:52:19 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA18159 for <linux@cthulhu.engr.sgi.com>; Sat, 24 Jan 1998 04:52:13 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA11134
	for <linux@cthulhu.engr.sgi.com>; Sat, 24 Jan 1998 04:52:11 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
From: ralf@mailhost.uni-koblenz.de
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id NAA09838;
	Sat, 24 Jan 1998 13:52:10 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id NAA13508; Sat, 24 Jan 1998 13:52:08 +0100
Message-ID: <19980124135207.55601@uni-koblenz.de>
Date: Sat, 24 Jan 1998 13:52:07 +0100
To: Mike Hill <mikehill@hgeng.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: (Cross-)Compiling a Kernel
References: <60222E63C9F4D011915F00A02435011C011AD1@bart.hgeng.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <60222E63C9F4D011915F00A02435011C011AD1@bart.hgeng.com>; from Mike Hill on Fri, Jan 23, 1998 at 09:42:12AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 23, 1998 at 09:42:12AM -0500, Mike Hill wrote:

> make dep
> make[1]: Entering directory
> `/usr/src/kernel-source-2.0.32/arch/i386/boot'
> make[1]: Nothing to be done for `dep'.
> make[1]: Leaving directory
> `/usr/src/kernel-source-2.0.32/arch/i386/boot'
> scripts/mkdep init/*.c > .tmpdepend
> scripts/mkdep `find /usr/src/kernel-source-2.0.32/include/asm
> /usr/src/kernel-source-2.0.32/include/linux
> /usr/src/kernel-source-2.0.32/include/scsi
> /usr/src/kernel-source-2.0.32/include/net -follow -name \*.h ! -name
> modversions.h -print` > .hdepend
> make: *** [dep-files] Error 139
> 
> I successfully compiled x86 kernels before the libc6 upgrade.  Can these
> failures be related?  Did I miss something in the upgrade?

Nothing obvious.

> Ralf:  I deleted the two `64' arguments in the IRIX 6.x target line of
> config.bfd, but my IRIX binutils quits compiling at the same place
> (stabs.c).

Are you talking about native IRIX binutils or the irix -> mips-linux
crosscompiler?  For the first case I recommend using the native IRIX
linker, for the later case you have to remove them from the entry
for mips-*-linux*.  See also the patch included in the binutils-2.8-2
rpm.

  Ralf
