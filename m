Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA19680; Mon, 20 May 1996 23:25:29 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA17803 for linux-list; Tue, 21 May 1996 06:25:25 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA17798 for <linux@cthulhu.engr.sgi.com>; Mon, 20 May 1996 23:25:24 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA06414 for <linux@yon.engr.sgi.com>; Mon, 20 May 1996 23:24:59 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA17794 for <linux@yon.engr.sgi.com>; Mon, 20 May 1996 23:25:22 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <linux@yon.engr.sgi.com> id XAA03232; Mon, 20 May 1996 23:25:21 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id CAA28911 for <linux@yon.engr.sgi.com>; Tue, 21 May 1996 02:25:20 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id CAA07005; Tue, 21 May 1996 02:25:20 -0400
Date: Tue, 21 May 1996 02:25:20 -0400
Message-Id: <199605210625.CAA07005@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: linux@yon.engr.sgi.com
Subject: some projections...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Iris SCSI driver: Mildly amusing, once I get the dma stuff straight
		  should be a 3 or 4 day affair to get going in an
		  initial working state.

Iris Ethernet driver: Cake walk, 3 nights tops.

It seems the HPC drives both of these devices in a similar manner, it
also seems that it has little state machines which do things like
retransmit collision packets on the SEEQ and various SCSI sequences as
well.  I need to get it straight in my head where the software driver
actually comes into play.  I like the HPC dma architecture btw.

Console driver: I assume the keyboard/mouse is driven off the Zilog
		uarts, if so this should be relatively simple as I can
		adapt most of the code from my Sparc stuff and how I
		layed that code out.  As for the screen I just need
		to figure out where the frame buffer lives and how to
		play with the palette registers and I'm set.  Also
		should be cakewalk to do serial console as well. This
		might be a 4 or 5 day job depending upon how things
		go initially.

So in less than two weeks I could have drivers for all the major
devices going already.

A large section of my work will be carefully going over the existing
code the linux-mips people have and putting together the initial
foundation so that I can at least start compiling kernels, then things
can run smoothly.

Yawn, stretch, more to come...

Later,
David S. Miller
davem@caip.rutgers.edu
