Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA2175213 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Mar 1998 13:22:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA4671703
	for linux-list;
	Fri, 27 Mar 1998 13:19:55 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA4648040
	for <linux@engr.sgi.com>;
	Fri, 27 Mar 1998 13:19:50 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA02355
	for <linux@engr.sgi.com>; Fri, 27 Mar 1998 13:19:48 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-19.uni-koblenz.de [141.26.249.19])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA17651
	for <linux@engr.sgi.com>; Fri, 27 Mar 1998 22:19:46 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA05999;
	Fri, 27 Mar 1998 22:19:30 +0100
Message-ID: <19980327221930.23662@uni-koblenz.de>
Date: Fri, 27 Mar 1998 22:19:30 +0100
To: linux@cthulhu.engr.sgi.com
Subject: initcode
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I implemented the initcode stuff for MIPS as well.  For my kernel
configuration I can reclaim 32kb of memory.

IRIX people: Linux can collect all the code that is only being used during
system startup in special ELF sections.  After system initialziation is
done the kernel frees those pages again.  Voila, instant memory.

  Ralf
