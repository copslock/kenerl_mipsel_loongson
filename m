Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id VAA01175 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Sep 1997 21:09:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA03497 for linux-list; Mon, 22 Sep 1997 21:09:01 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA03481 for <linux@cthulhu.engr.sgi.com>; Mon, 22 Sep 1997 21:08:56 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id VAA26845 for <linux@fir.engr.sgi.com>; Mon, 22 Sep 1997 21:08:52 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA03471 for <linux@fir.engr.sgi.com>; Mon, 22 Sep 1997 21:08:51 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA25930
	for <linux@fir.engr.sgi.com>; Mon, 22 Sep 1997 21:08:50 -0700
	env-from (ralf@dns.cobaltmicro.com)
Received: (from ralf@localhost)
	by dns.cobaltmicro.com (8.8.5/8.8.5) id VAA15154;
	Mon, 22 Sep 1997 21:09:11 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Message-Id: <199709230409.VAA15154@dns.cobaltmicro.com>
Subject: Re: Task list --preliminary list
To: linux-mips@fnet.fr
Date: Mon, 22 Sep 1997 21:09:11 -0700 (PDT)
Cc: miguel@nuclecu.unam.mx, linux@fir.engr.sgi.com
In-Reply-To: <34273C4E.9AD0AB2F@detroit.sgi.com> from "Eric Kimminau" at Sep 22, 97 11:49:34 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> PRI 10
> Howto updated so it show how to take a system currently running IRIX and
> get it to a point where it is running Linux. I know it isn't truly
> development work, but Ive been stuck with a non-functional Indy for most
> of a month.My problems seem to be related to trying to NFS boot off of a
> remote XFS file system but I could be wrong. I haven't grabbed the
> latest kernel to try so that could resolve my issue.

This issues might have been resolved by Miguel's latest CVS commit.
Your NFS problems might also have been cause by the VFS rewrite which
was essentially turning the filesystems into an inferno for a limited
time.

  Ralf
