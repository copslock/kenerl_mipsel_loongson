Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id UAA138635 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Jan 1998 20:25:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA16323 for linux-list; Sun, 11 Jan 1998 20:25:08 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA16286; Sun, 11 Jan 1998 20:24:59 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id UAA18210; Sun, 11 Jan 1998 20:24:50 -0800
Date: Sun, 11 Jan 1998 20:24:50 -0800
Message-Id: <199801120424.UAA18210@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>,
        Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: something not really right ..
In-Reply-To: <19980110120428.62352@thoma.uni-koblenz.de>
References: <Pine.SGI.3.94.980109200218.2493B-100000@tantrik.engr.sgi.com>
	<19980110120428.62352@thoma.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > On Fri, Jan 09, 1998 at 08:04:57PM -0800, Shrijeet Mukherjee wrote:
 > > 
 > > I tried to compile the latest sources for an Indigo R4k .. with minimal
 > > functionality .. i.e. most of the newer stuff has been left out.
 > > 
 > > after the compilation, trying to bring the machine up by serving the
 > > kernel via NFS/BOOTP gets me this message 
 > > 
 > > sash
 > > "unable to execute bootp()tantrik:/usr/local/boot/vmlinux: Not enough
 > > space"
 > > "unable to load bootp()tantrik:/usr/local/boot/vmlinux: Not enough space"
 > > sash
 > 
 > Did you modify the load address of the kernel?  Indy kernels are by
 > default linked for address 0x88002000 because the Indy has a 128mb
 > hole in it's address space there.  I assumes (wje???) that your box
 > has it's memory mapped from 0x80000000 upwards, so this would only
 > work if you actually have that more than 128mb ...
 > 

     Indy and Indigo R40000 both have the hole at the bottom of the
address space, so main memory is mapped starting at 0x88000000, with
512 KB double-mapped at 0x80000000.
