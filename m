Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA18082; Tue, 15 Jul 1997 11:26:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA14337 for linux-list; Tue, 15 Jul 1997 11:25:58 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA14295 for <linux@cthulhu.engr.sgi.com>; Tue, 15 Jul 1997 11:25:52 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA05242
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Jul 1997 11:08:02 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id SAA15866;
	Tue, 15 Jul 1997 18:05:40 -0500
Date: Tue, 15 Jul 1997 18:05:40 -0500
Message-Id: <199707152305.SAA15866@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Linux/SGI questions for tuesday.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Another question for all of you having access to the Xsgi X server
sources.  

I am reading the Virtual DMA specification, and it occurs to me that
this is the only way I can dma from the graphics card and to the
graphics card.  Can someone confirm this?

According to the document I have, to be able to use the VDMA, a least
for R4000 machines, I need support from the kernel, can somebody tell
me what this kernel support looks like?

I can't find anything in the par output I have from running the X
server that looks like VDMA setup.

Have a nice day,
miguel.
