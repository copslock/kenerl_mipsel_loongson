Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA82797 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Feb 1999 21:15:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA20918
	for linux-list;
	Fri, 5 Feb 1999 21:15:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA82462
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 5 Feb 1999 21:14:59 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA03629
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Feb 1999 21:14:57 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA05064
	for <linux@cthulhu.engr.sgi.com>; Sat, 6 Feb 1999 00:18:03 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 6 Feb 1999 00:18:03 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: HAL module problems?
Message-ID: <Pine.LNX.3.96.990206001654.26740C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm not quite sure what the problem here is, but when I rebuild my kernel
freshly, directly from what's in CVS, and I use the same kernel that
matches the module, I get:

[root@black linux]# /sbin/insmod hal2
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol __wake_up
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol kmalloc
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol unregister_chrdev
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol register_chrdev
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol __get_free_pages
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol interruptible_sleep_on
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol kfree
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol loops_per_sec
/lib/modules/2.1.131/misc/hal2.o: unresolved symbol printk

Am I insane?

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
