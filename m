Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA343279; Tue, 2 Sep 1997 15:06:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA18496 for linux-list; Tue, 2 Sep 1997 15:02:02 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA18452 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 15:01:52 -0700
Received: from gatekeeper.qms.com (gatekeeper.qms.com [161.33.3.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id PAA21543
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 15:01:51 -0700
	env-from (marks@sun470.sun470.rd.qms.com)
Received: from sun470.rd.qms.com (sun470.qms.com) by gatekeeper.qms.com (4.1/SMI-4.1)
	id AA28960; Tue, 2 Sep 97 17:01:45 CDT
Received: from speedy.rd.qms.com by sun470.rd.qms.com (4.1/SMI-4.1)
	id AA27618; Tue, 2 Sep 97 17:01:43 CDT
Received: by speedy.rd.qms.com (8.8.2) id RAA26782; Tue, 2 Sep 1997 17:01:43 -0500
Date: Tue, 2 Sep 1997 17:01:43 -0500
Message-Id: <199709022201.RAA26782@speedy.rd.qms.com>
From: Mark Salter <marks@sun470.sun470.rd.qms.com>
To: adevries@engsoc.carleton.ca
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: 
	<Pine.LNX.3.95.970902173244.5212A-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Tue, 2 Sep 1997 17:47:13 -0400 (EDT))
Subject: Re: Booting off of sdb1...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> The kernel starts, and it finishes off with:

> Partition check:
>  sda: sad1 sda2 sda3 sda4
>  sdb: sdb1 sdb2 sdb3
> VFS: Mounted root (ext2 filesystem) readonly.
> : Can't open

> And then nothing.

> What am I missing?

> - Alex


>       Alex deVries              Success is realizing 
>   System Administrator          attainable dreams.
>    The EngSoc Project     


Try this patch to linux/arch/mips/sgi/prom/cmdline.c:

*** cmdline.c.orig      Tue Sep  2 16:59:26 1997
--- cmdline.c   Tue Sep  2 15:59:04 1997
***************
*** 52,57 ****
--- 52,59 ----
        pic_cont:
                actr++;
        }
+       if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
+               --cp;
        *cp = '\0';
  
  #ifdef DEBUG_CMDLINE


--Mark
