Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA126689 for <linux-archive@neteng.engr.sgi.com>; Mon, 26 Jan 1998 15:35:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA06901 for linux-list; Mon, 26 Jan 1998 15:32:29 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA06886 for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 15:32:24 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA16694
	for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 15:32:23 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-16.uni-koblenz.de [141.26.249.16])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA08781
	for <linux@cthulhu.engr.sgi.com>; Tue, 27 Jan 1998 00:32:20 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA05531;
	Mon, 26 Jan 1998 23:47:14 +0100
Message-ID: <19980126234714.47225@uni-koblenz.de>
Date: Mon, 26 Jan 1998 23:47:14 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Boot flags in the kernel.
References: <Pine.LNX.3.95.980126004413.18537A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980126004413.18537A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Jan 26, 1998 at 01:05:14AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 26, 1998 at 01:05:14AM -0500, Alex deVries wrote:

> I'm not sure if what I'm trying to do is possible. I'm trying to implement
> the same rootflags that are passwd within the kernel image in i386 into
> the MIPS kernel. 
> 
> In i386 there's a portion of the boot image reserved for these flags;
> they're things like console type, initial filesystem, initial ramdisk
> location, etc.  
> 
> It's traditionally been more important to have this feature in i386
> because there wasn't anything nice like the PROMs on MIPS or Sparcs.
> 
> But, there _is a good reason to have it; for install or rescue images it's
> nice to be able to boot with compressed initial ramdisk within the same
> boot image without having to pass the ramdisk offset on command line
> manually.
> 
> Where in the kernel would we put this data?

If you _really_ need that you can copy the data into the .data segment
during the initialization.  See arch/mips/kernel/setup.c.

  Ralf
