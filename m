Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id DAA13738 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Jan 1998 03:04:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA03406 for linux-list; Sat, 10 Jan 1998 03:04:37 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA03393; Sat, 10 Jan 1998 03:04:34 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA27351; Sat, 10 Jan 1998 03:04:31 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id MAA04289;
	Sat, 10 Jan 1998 12:04:30 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id MAA06589; Sat, 10 Jan 1998 12:04:29 +0100
Message-ID: <19980110120428.62352@thoma.uni-koblenz.de>
Date: Sat, 10 Jan 1998 12:04:28 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
Cc: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: something not really right ..
References: <Pine.SGI.3.94.980109200218.2493B-100000@tantrik.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.SGI.3.94.980109200218.2493B-100000@tantrik.engr.sgi.com>; from Shrijeet Mukherjee on Fri, Jan 09, 1998 at 08:04:57PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 09, 1998 at 08:04:57PM -0800, Shrijeet Mukherjee wrote:
> 
> I tried to compile the latest sources for an Indigo R4k .. with minimal
> functionality .. i.e. most of the newer stuff has been left out.
> 
> after the compilation, trying to bring the machine up by serving the
> kernel via NFS/BOOTP gets me this message 
> 
> sash
> "unable to execute bootp()tantrik:/usr/local/boot/vmlinux: Not enough
> space"
> "unable to load bootp()tantrik:/usr/local/boot/vmlinux: Not enough space"
> sash

Did you modify the load address of the kernel?  Indy kernels are by
default linked for address 0x88002000 because the Indy has a 128mb
hole in it's address space there.  I assumes (wje???) that your box
has it's memory mapped from 0x80000000 upwards, so this would only
work if you actually have that more than 128mb ...

  Ralf
