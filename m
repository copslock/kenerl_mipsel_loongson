Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA15946; Thu, 16 May 1996 15:27:34 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA29186 for linux-list; Thu, 16 May 1996 22:26:09 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA29178 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 15:26:08 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA15897 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 15:26:06 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA29164 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 15:26:05 -0700
Received: from snowcrash.cymru.net by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id PAA21591; Thu, 16 May 1996 15:25:59 -0700
Received: from lxorguk.ukuu.org.uk (Ulxorguk@localhost) by snowcrash.cymru.net (8.7.1/8.7.1) with UUCP id XAA01922 for neteng.engr.sgi.com!lmlinux; Thu, 16 May 1996 23:12:14 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0uK6ux-0005FbC; Thu, 16 May 96 18:32 BST
Message-Id: <m0uK6ux-0005FbC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: lmbench with new checksum code...
To: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
Date: Thu, 16 May 1996 18:32:51 +0100 (BST)
Cc: davem@caip.rutgers.edu, lmlinux@neteng.engr.sgi.com,
        torvalds@cs.Helsinki.FI, sparclinux-cvs@caipfs.rutgers.edu,
        alan@cymru.net
In-Reply-To: <199605161603.JAA03193@neteng.engr.sgi.com> from "Larry McVoy" at May 16, 96 09:03:36 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I think your 4.8MB/sec number is pretty studly.  That means you are 
> checksumming 9MB/sec as well as the protocol stack on a system that 

Actually the Linux kernel cheats on the receive side of loopback and doesnt
checksum. Its too expensive to fiddle around on the send side for that short
of doing the whole job and shorting the tcp layer as Solaris seems to.

> bcopies at ~20MB/sec.  You're already better than 2x the SunOS code.
> Call it a day, you won.

Na.. We can cut all the checksums, do raw copies with no protocol overhead
and possibly later on do user->user copying (with page flips to keep larry
happy ;)). I can't see any reason we cannot do about 8-9MB/sec with a bit
of extra code and some sneaky tricks.

CONFIG_TCP_BENCHMARK_TRICKS 

anyone ?
