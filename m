Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA1343284 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 15:33:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA00467 for linux-list; Fri, 5 Sep 1997 15:31:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA00393 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 15:31:16 -0700
Received: from gatekeeper.qms.com (gatekeeper.qms.com [161.33.3.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id PAA03312
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 15:31:09 -0700
	env-from (marks@sun470.sun470.rd.qms.com)
Received: from sun470.rd.qms.com (sun470.qms.com) by gatekeeper.qms.com (4.1/SMI-4.1)
	id AA28446; Fri, 5 Sep 97 17:31:02 CDT
Received: from speedy.rd.qms.com by sun470.rd.qms.com (4.1/SMI-4.1)
	id AA00261; Fri, 5 Sep 97 17:31:00 CDT
Received: by speedy.rd.qms.com (8.8.2) id RAA21201; Fri, 5 Sep 1997 17:30:59 -0500
Date: Fri, 5 Sep 1997 17:30:59 -0500
Message-Id: <199709052230.RAA21201@speedy.rd.qms.com>
From: Mark Salter <marks@sun470.sun470.rd.qms.com>
To: shaver@neon.ingenia.ca
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199709050458.AAA16971@neon.ingenia.ca> (message from Mike Shaver
	on Fri, 5 Sep 1997 00:58:04 -0400 (EDT))
Subject: Re: Kernel for local disk stuff
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Mike Shaver said:
> because heavy ethernet traffic occasionally generates bus errors that
> lock up the box.  I'm going to take a look at what causes those
> tomorrow, hopefully.

These finally annoyed me to the point I started looking at it today. I
was able to hack the buserr irq handler to set up a gdb frame so that
gdb gets control at the instruction that was interrupted. The problem
appears to be in sgiseeq.c which is no great surprise since it occurs
during times of heavy network traffic. The bus error irqs always occur
when interrupts are reenabled in the ret_from_sys_call after a sgiseeq
irq. The hpc_ethregs tx_ctrl value is 0x1 indicating that transmit was
inactive, but there was an underflow. The tx_ndptr value is 0xffffffff.
The latter I think leads to the bus error. Look at kick_tx() being
called from sgiseeq_tx() during the handling of the interrupt. With
that value of tx_ndptr, kick_tx would end up writing to 0xbffffff0
which is not we want to do. I don't have the HPC docs, so I'm probably
not going to be able to come up with a proper fix...

--Mark
