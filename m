Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA61060 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Jan 1998 09:42:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA02108 for linux-list; Sat, 10 Jan 1998 09:37:00 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA02103 for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 09:36:57 -0800
Received: from nic.cerf.net (nic.cerf.net [192.102.249.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA20792
	for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 09:36:57 -0800
	env-from (bellis@cerf.net)
Received: from maelstrom.cerf.net (maelstrom.cerf.net [198.137.140.16]) by nic.cerf.net (1.1.1/8.8.8) with SMTP id JAA11130 for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 09:36:38 -0800 (PST)
Date: Sat, 10 Jan 1998 09:38:20 -0800 (PST)
From: William Ellis <bellis@cerf.net>
To: linux@cthulhu.engr.sgi.com
Subject: SGI/Linux on a Challenge S series
In-Reply-To: <19980110120428.62352@thoma.uni-koblenz.de>
Message-ID: <Pine.SOL.3.94.980110093122.2895A-100000@maelstrom.cerf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



I just got hold of a spare Challenge S Series(R5000) I was
going to attempt putting SGI/Linux on.  I know the porting is
basicaly geared for the Indy's but I was going to muck with it
a bunch. Then I just saw this post and was wondering if there 
was any quick, good heads-up for these machines.  
Thanks, Bill 

>> I tried to compile the latest sources for an Indigo R4k .. with minimal
[*snip*]
> Did you modify the load address of the kernel?  Indy kernels are by
> default linked for address 0x88002000 because the Indy has a 128mb
> hole in it's address space there.  I assumes (wje???) that your box
> has it's memory mapped from 0x80000000 upwards, so this would only
> work if you actually have that more than 128mb ...
>   Ralf
