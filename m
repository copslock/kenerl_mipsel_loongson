Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA18805 for <linux-archive@neteng.engr.sgi.com>; Fri, 16 Apr 1999 13:03:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA80592
	for linux-list;
	Fri, 16 Apr 1999 13:01:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA95846
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 16 Apr 1999 13:00:59 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (pr250.pheasantrun.net [208.140.225.250]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03685
	for <linux@cthulhu.engr.sgi.com>; Fri, 16 Apr 1999 13:00:54 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from tool.foo.tho.org (clepple@tool.foo.tho.org [206.223.45.1])
	by foo.tho.org (8.8.7/8.8.7) with ESMTP id QAA13269
	for <linux@cthulhu.engr.sgi.com>; Fri, 16 Apr 1999 16:00:53 -0400
Date: Fri, 16 Apr 1999 16:00:53 -0400 (EDT)
From: Charles Lepple <clepple@foo.tho.org>
To: linux@cthulhu.engr.sgi.com
Subject: Boot problems with locally compiled kernel
Message-ID: <Pine.LNX.4.04.9904161555520.13259-100000@foo.tho.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Now that I can finally get the kernel compile to finish, I end up with a
message similar to the folowing after the kernel is loaded (it's still in
the textport):

Exception: <vector=UTLB Miss>
Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
...

This is an R5k machine, and I've tried both the r4x00 and r5000 options,
in addition to converting the kernel to ECOFF (with the program in
arch/mips/boot). This is a CVS tree from yesterday or so -- any thoughts
on this one? (I checked the old archives -- sorry if this is a FAQ and I
just missed it).

Thanks,

--
Charles Lepple
System Administrator, Virginia Tech EE Workstation Labs
clepple@foo.tho.org || http://foo.tho.org/charles/
