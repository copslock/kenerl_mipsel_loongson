Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA2166497 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Mar 1998 13:08:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA4578665
	for linux-list;
	Fri, 27 Mar 1998 13:06:23 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA4514553
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 27 Mar 1998 13:06:18 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA27584
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Mar 1998 13:06:15 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-19.uni-koblenz.de [141.26.249.19])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA16795
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Mar 1998 22:06:12 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA05914;
	Fri, 27 Mar 1998 22:05:53 +0100
Message-ID: <19980327220550.50946@uni-koblenz.de>
Date: Fri, 27 Mar 1998 22:05:50 +0100
To: Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
References: <199803272025.PAA16215@pluto.npiww.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199803272025.PAA16215@pluto.npiww.com>; from Dong Liu on Fri, Mar 27, 1998 at 03:25:08PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Mar 27, 1998 at 03:25:08PM -0500, Dong Liu wrote:

> I'm new to sgi linux, just got a spare Indy :=), can some one help me on this.
> 
> According the linux sgi FAQ on http://www.linux.sgi.com, I download
> vmlinux-970916-efs and the small root fs. When I boot it using bootp,
> I get 
> 
> Unable to handle kernel paging request at virtual address 00000000,
> epc == 800cbfdc, ra == 800cbfbc

The addresses 0x800cbfdc / 0x800cbfbc are not valid kernel addresses on
the Indy.  Is it possible you wrote them down wrong?  0x880cbfdc /
0x880cbfbc however would make sense and are indeed in the sgiseeq driver.
I'll take a closer look at it.

> right after linux kernel displayed
> 
> eth0: SGI Seeq8003 xx:xx:xx:xx:xx:xx
> 
> I also noticed that something unusual, the kernel printed out
> 
> Memory: 60964/196604k avaialble (1020k kernel code, 2772k data)
>               ^^^^^^ this is too big for 62M

The message is correct.  The difference is because of a hole in the Indy's
address space comparable to the 640kb - 1024kb hole on PCs.

(This should go into the FAQ)

> My machine is a Indy which has 62M memory, and PROMLIB detected it right.
> 
> Another thing it didn't get the right capacity of scsi disk.

Are you shure?  Some peopple got fooled by the 1024 vs. 1024 bytes per
kb isue ...  Or are the numbers way off?

> I also tried the newer kernels from ftp.linux.sgi.com:/pub/test, but
> they immediately crashed.

There is a command named ``hinv'' under IRIX.  Can you mail me the output?

I'm going to put binaries of 2.0.91 online.  That kernel seems to be
running very reliable for me.  In fact it's too reliable to debug, I can't
reproduce the one killer bug I know of it must be still there ...

  Ralf
