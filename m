Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA2595312 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Apr 1998 11:47:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id LAA6542932
	for linux-list;
	Wed, 1 Apr 1998 11:46:31 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA6562753
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Apr 1998 11:46:29 -0800 (PST)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id LAA23688
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 11:46:27 -0800 (PST)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id OAA20234 for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 14:54:49 -0500
Date: Wed, 1 Apr 1998 15:01:38 -0500
Message-Id: <199804012001.PAA15976@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
In-Reply-To: <Pine.LNX.3.96.980401203750.31891C-100000@web.aec.at>
References: <19980401202840.22363@uni-koblenz.de>
	<Pine.LNX.3.96.980401203750.31891C-100000@web.aec.at>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Oliver Frommel writes:
 > > > Ralf sent me a patch and i recompiled the 2.1.90 kernel with it applied.
 > > > You can find it on ftp://zero.aec.at/pub/sgi-linux/linux-980326-1.tar.gz
 > > 
 > > Stop the presses.  This is not my day.  I'm sending you a new patch.
 > >
 > 
 > you can get ftp://zero.aec.at/pub/sgi-linux/linux-980326-2.tar.gz now ..
 > 
 > -oliver
 >  
 > 

I got it, now the SCSI is working, it correctly recongnized my scsi
disck, but I got 

Ubable to handle kernel paging request at virtual address 00000000, epc == 880ce1f4, ra == 880ce1d4
Oops 0001

right after 

eth0: SGI Seeq8003 xx:xx:xx:xx:xx

I try mips-linux-addr2line, it didn't give me anything, I guess Oliver
didn't compile it with -g.

Dong
