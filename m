Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA734855 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Sep 1997 20:47:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA00748 for linux-list; Mon, 22 Sep 1997 20:47:07 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA00725; Mon, 22 Sep 1997 20:47:04 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA22027; Mon, 22 Sep 1997 20:47:02 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id WAA17103;
	Mon, 22 Sep 1997 22:35:49 -0500
Date: Mon, 22 Sep 1997 22:35:49 -0500
Message-Id: <199709230335.WAA17103@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: ariel@cthulhu.engr.sgi.com
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199709230305.UAA09789@oz.engr.sgi.com> (ariel@oz.engr.sgi.com)
Subject: Re: Task list --preliminary list
X-Windows: It could be worse, but it'll take time.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> [5] Verify that the latest source tree on Llinus compiles and boots
>     (maybe automate this with a daily build that gets tested)

I checked this yesterday when I commited my code to linus.

> [4] Utility to boot Linux from IRIX (both locally and over net)

Well, we do not need this, since sash can load the Linux kernel from
both an efs file system and from the network.  I thought this had been
covered in the HOWTO?

	Booting from local disk:

	1. Put your kernel on an EFS partition say, /linux/vmlinux.gz

	2. reset your Indy.

	3. Enter maintenance mode (click on the button before IRIX
	   boots).

	4. at the prompt type:  boot /linux/vmlinux.gz

	Note that I lack a manual on the ARC, so I am limited by what
	I figured would boot the kernel.  There are some very interesting
	variables that allow you to boot the kernel from any file
	system on any partition.
	
> [3] Stable precompiled Indy kernel + root-contents on linus

	I have my stable precompiled Indy kernel, I can setup a cron
	job to upload my latest kernel everyday :-).  They are always
	stable.

	My root contents are currently pretty hosed up, as I have a mixture
	of IRIX, Linux and gnemul + some rpms + some broken rpms + a libc
	that I am not sure it is ok. 

Cheers,
Miguel.
