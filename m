Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA17129 for <linux-archive@neteng.engr.sgi.com>; Wed, 27 Jan 1999 16:49:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA51213
	for linux-list;
	Wed, 27 Jan 1999 16:48:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA78888
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 27 Jan 1999 16:48:12 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09220
	for <linux@cthulhu.engr.sgi.com>; Wed, 27 Jan 1999 16:48:09 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA22773;
	Wed, 27 Jan 1999 19:49:51 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 27 Jan 1999 19:49:51 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "Ulf Carlson <ulfc@bun.falkenberg.se>" <ulfc@linus.linux.sgi.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: CVS Update@linus.linux.sgi.com: linux
In-Reply-To: <199901280038.QAA15106@linus.linux.sgi.com>
Message-ID: <Pine.LNX.3.96.990127194857.25641K-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


okay, here's the output of mine:

[root@black linux]# /sbin/insmod hal2

SGI HAL2 Processor, Revision 4.1.0
hal2: checking registers
hal2: waiting isr:0000 idr0:0000 idr1:0000 idr2:0000 idr3:0000
hal2: finished waiting at cnt:0 isr:03e8 idr0:0000 idr1:0000 idr2:0000
idr3:0000
hal2: wrote #1
hal2: waiting isr:0000 idr0:0000 idr1:0000 idr2:0000 idr3:0000
hal2: finished waiting at cnt:0 isr:03e8 idr0:0000 idr1:0000 idr2:0000
idr3:0000
hal2: wrote #2
hal2: waiting isr:0000 idr0:0000 idr1:0000 idr2:0000 idr3:0000
hal2: finished waiting at cnt:0 isr:03e8 idr0:0000 idr1:0000 idr2:0000
idr3:0000
hal2: Didn't pass register check #1 (0000)
sgiaudio: unable to find hal2 subsystem



-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.


On Wed, 27 Jan 1999, Ulf Carlson <ulfc@bun.falkenberg.se> wrote:

> Date: Wed, 27 Jan 1999 16:38:49 -0800
> From: "Ulf Carlson <ulfc@bun.falkenberg.se>" <ulfc@linus.linux.sgi.com>
> To: linux-cvs@linus.linux.sgi.com
> Subject: CVS Update@linus.linux.sgi.com: linux
> 
> CVSROOT:	/src/cvs
> Module name:	linux
> Changes by:	ulfc@linus.linux.sgi.com	99/01/27 16:38:48
> 
> Modified files:
> 	drivers/sgi/audio: hal2.c 
> 
> Log message:
> 	some more printks and minor changes
> 	
> 	Ralf: We might need a hand here
> 
