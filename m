Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA2666962 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Apr 1998 23:31:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id XAA6801203
	for linux-list;
	Wed, 1 Apr 1998 23:29:44 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA6753833
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Apr 1998 23:29:40 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id XAA04146
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 23:29:38 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-23.uni-koblenz.de [141.26.249.23])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id JAA13255
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 09:29:21 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id JAA00701;
	Thu, 2 Apr 1998 09:27:34 +0200
Message-ID: <19980402092733.57040@uni-koblenz.de>
Date: Thu, 2 Apr 1998 09:27:33 +0200
To: Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
References: <19980401202840.22363@uni-koblenz.de> <Pine.LNX.3.96.980401203750.31891C-100000@web.aec.at> <199804012001.PAA15976@pluto.npiww.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804012001.PAA15976@pluto.npiww.com>; from Dong Liu on Wed, Apr 01, 1998 at 03:01:38PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 01, 1998 at 03:01:38PM -0500, Dong Liu wrote:

> I got it, now the SCSI is working, it correctly recongnized my scsi
> disck, but I got 
> 
> Ubable to handle kernel paging request at virtual address 00000000, epc == 880ce1f4, ra == 880ce1d4
> Oops 0001
> 
> right after 
> 
> eth0: SGI Seeq8003 xx:xx:xx:xx:xx

I bet it's ``... at virtual address 00000008 ...'', not zero?

People, when writing down these number, please be careful.

> I try mips-linux-addr2line, it didn't give me anything, I guess Oliver
> didn't compile it with -g.

It's quite usless that to the aggressive use of inline functions and -O2
optimizations in Linux anyway.

  Ralf
