Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA36638 for <linux-archive@neteng.engr.sgi.com>; Mon, 23 Nov 1998 12:39:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA52835
	for linux-list;
	Mon, 23 Nov 1998 12:38:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id MAA61461
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 23 Nov 1998 12:38:40 -0800 (PST)
	mail_from (chad@roctane.dallas.sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	for <@sgidal.dallas.sgi.com:linux@cthulhu.engr.sgi.com> id OAA11960; Mon, 23 Nov 1998 14:38:39 -0600
Received: from roctane.dallas.sgi.com (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA02217 for <linux@cthulhu.engr.sgi.com>; Mon, 23 Nov 1998 12:38:38 -0800 (PST)
Message-ID: <3659C7CD.1B134991@roctane.dallas.sgi.com>
Date: Mon, 23 Nov 1998 14:38:37 -0600
From: Chad Carlin <chad@roctane.dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: New to Linux
References: <199810310228.SAA34114@oz.engr.sgi.com> <19981105031325.P359@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Help.

Here is what I have:
Indy: R4k indy w/ a 1GB and a 500MB disk. I have an external 9GB from my
other system that I am temorarily (I hope) using to boot IRIX on my Linux
Indy.

Software:
Linux-installer-0.2.tar
root-be-0.04.cpio
SRPMS
vmlinux-indy-2.1.99.tar.gz
instructions

I read the instructions. The one with all of the tftp and nfs setup. Is
this for after I boot Linux, so I can install the rest of the software?
BTW I tested this by booting miniroot from my other Indy.

I also read the INSTALL instructions. I was able to successfully: ./mke2fs
drive, ./installer drive,  cjwsh> MAKEDEV, cpio root-be-0.04.cpio, and
./e2fsck -fy drive. Finally I did the, gzip -dc vmlinux.gz > /vmlinux. All
of this went OK.

It's the "boot vmlinux root=/dev/sda0" that makes the indy panic! Do I do
this from PROM or sash? I don't think that I can read the efs filesystem
without sash. Is there a better way to determine what device my e2fs root
filesystem is at?

Tell me if I'm getting this proceedure right.

1)Boot vmlinux kernel and mount e2fs filesystem as /.
2)Use tftp to install the stuff that I downloaded in the SRPMS directory.
3)Somehow I will end up with a system that can boot without having IRIX on
a local disk.

BTW is there anyway to mount this e2fs filesystem from with IRIX?

Thanks for any and all input. Flame me if you must.
Chad
