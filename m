Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id GAA206989 for <linux-archive@neteng.engr.sgi.com>; Fri, 23 Jan 1998 06:45:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA02019 for linux-list; Fri, 23 Jan 1998 06:40:28 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA02007 for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 06:40:23 -0800
Received: from sagittarius.tor.onramp.ca (sagittarius.tor.onramp.ca [204.225.88.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id GAA28692
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 06:40:22 -0800
	env-from (mikehill@hgeng.com)
Received: (qmail 24304 invoked from network); 23 Jan 1998 14:40:21 -0000
Received: from onramp.ca (root@204.225.88.3)
  by sagittarius.tor.onramp.ca with SMTP; 23 Jan 1998 14:40:21 -0000
Received: from bart.hgeng.com(imail.hgeng.com[199.246.72.233]) (2253 bytes) by onramp.ca
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <mikehill@hgeng.com>) 
	id <m0xvkHI-000tQkC@onramp.ca>
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 09:40:16 -0500 (EST)
	(Smail-3.2.0.98 1997-Oct-16 #11 built 1997-Oct-23)
Received: by bart.hgeng.com with Internet Mail Service (5.5.1960.3)
	id <DD2TN3YF>; Fri, 23 Jan 1998 09:42:13 -0500
Message-ID: <60222E63C9F4D011915F00A02435011C011AD1@bart.hgeng.com>
From: Mike Hill <mikehill@hgeng.com>
To: linux@cthulhu.engr.sgi.com
Subject: (Cross-)Compiling a Kernel
Date: Fri, 23 Jan 1998 09:42:12 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.1960.3)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In December I upgraded my x86 Linux box to Debian libc6.  Earlier this
month I successfully built the x86 binutils 2.8.1 for cross-compiling
the SGI/Linux kernel, but couldn't get through `make dep' when compiling
the kernel (2.1.72).  Here is the result:

make dep
make[1]: Entering directory `/usr/local/src/linux/arch/mips/boot'
mips-linux-gcc -D__KERNEL__ -I/usr/local/src/linux/include -E -M *.[cS]
> .depend
make[1]: Leaving directory `/usr/local/src/linux/arch/mips/boot'
scripts/mkdep init/*.c > .tmpdepend
find  -follow -name \*.h ! -name modversions.h -print | env -i xargs
scripts/mkdep > .hdepend
xargs: scripts/mkdep: terminated by signal 11
make: *** [dep-files] Error 125


This week I attempted to re-compile the native kernel (2.0.32) to handle
a new CD drive.  It gets stuck at the same place.

make dep
make[1]: Entering directory
`/usr/src/kernel-source-2.0.32/arch/i386/boot'
make[1]: Nothing to be done for `dep'.
make[1]: Leaving directory
`/usr/src/kernel-source-2.0.32/arch/i386/boot'
scripts/mkdep init/*.c > .tmpdepend
scripts/mkdep `find /usr/src/kernel-source-2.0.32/include/asm
/usr/src/kernel-source-2.0.32/include/linux
/usr/src/kernel-source-2.0.32/include/scsi
/usr/src/kernel-source-2.0.32/include/net -follow -name \*.h ! -name
modversions.h -print` > .hdepend
make: *** [dep-files] Error 139

I successfully compiled x86 kernels before the libc6 upgrade.  Can these
failures be related?  Did I miss something in the upgrade?

Ralf:  I deleted the two `64' arguments in the IRIX 6.x target line of
config.bfd, but my IRIX binutils quits compiling at the same place
(stabs.c).

Thanks,

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
