Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA2164467 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Mar 1998 12:11:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA3103528
	for linux-list;
	Fri, 27 Mar 1998 12:10:19 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA1918947
	for <linux@engr.sgi.com>;
	Fri, 27 Mar 1998 12:10:17 -0800 (PST)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id MAA07227
	for <linux@engr.sgi.com>; Fri, 27 Mar 1998 12:10:12 -0800 (PST)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id PAA01304 for <linux@engr.sgi.com>; Fri, 27 Mar 1998 15:17:34 -0500
Date: Fri, 27 Mar 1998 15:25:08 -0500
Message-Id: <199803272025.PAA16215@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: linux@cthulhu.engr.sgi.com
Subject: new to sgi linux
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello,

I'm new to sgi linux, just got a spare Indy :=), can some one help me on this.

According the linux sgi FAQ on http://www.linux.sgi.com, I download
vmlinux-970916-efs and the small root fs. When I boot it using bootp,
I get 

Unable to handle kernel paging request at virtual address 00000000,
epc == 800cbfdc, ra == 800cbfbc

right after linux kernel displayed

eth0: SGI Seeq8003 xx:xx:xx:xx:xx:xx

I also noticed that something unusual, the kernel printed out

Memory: 60964/196604k avaialble (1020k kernel code, 2772k data)
              ^^^^^^ this is too big for 62M
   
My machine is a Indy which has 62M memory, and PROMLIB detected it right.

Another thing it didn't get the right capacity of scsi disk.

I also tried the newer kernels from ftp.linux.sgi.com:/pub/test, but
they immediately crashed.

Thanks.

Dong
