Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA135068 for <linux-archive@neteng.engr.sgi.com>; Mon, 26 Jan 1998 15:52:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA11733 for linux-list; Mon, 26 Jan 1998 15:49:26 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA11727 for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 15:49:25 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA22277
	for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 15:49:17 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA03162;
	Mon, 26 Jan 1998 18:49:57 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 26 Jan 1998 18:49:57 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Boot flags in the kernel.
In-Reply-To: <19980126234714.47225@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980126184552.20316G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 26 Jan 1998 ralf@uni-koblenz.de wrote:
> > Where in the kernel would we put this data?
> 
> If you _really_ need that you can copy the data into the .data segment
> during the initialization.  See arch/mips/kernel/setup.c.

But where would I copy it from? Where in the image would the symbols go?

Would I just put this in after kernel_entry and kernel_end are written in
mkboot.c (around lines 620-640)?

- A
