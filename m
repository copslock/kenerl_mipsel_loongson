Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA136512 for <linux-archive@neteng.engr.sgi.com>; Mon, 26 Jan 1998 16:15:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA20081 for linux-list; Mon, 26 Jan 1998 16:11:44 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA20061 for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 16:11:39 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA02111
	for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 16:11:37 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-16.uni-koblenz.de [141.26.249.16])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA16795
	for <linux@cthulhu.engr.sgi.com>; Tue, 27 Jan 1998 01:11:35 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA06528;
	Tue, 27 Jan 1998 01:08:04 +0100
Message-ID: <19980127010804.64864@uni-koblenz.de>
Date: Tue, 27 Jan 1998 01:08:04 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Boot flags in the kernel.
References: <19980126234714.47225@uni-koblenz.de> <Pine.LNX.3.95.980126184552.20316G-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980126184552.20316G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Jan 26, 1998 at 06:49:57PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 26, 1998 at 06:49:57PM -0500, Alex deVries wrote:

> On Mon, 26 Jan 1998 ralf@uni-koblenz.de wrote:
> > > Where in the kernel would we put this data?
> > 
> > If you _really_ need that you can copy the data into the .data segment
> > during the initialization.  See arch/mips/kernel/setup.c.
> 
> But where would I copy it from?

Thinking about it, actually it's _way_ more elegant to write just a couple
of lines brewing the right argument line to pass to the kernel and to
just pass it than patching the command line in the kernel binary ...

Where in the image would the symbols go?

No symbols needed.

> Would I just put this in after kernel_entry and kernel_end are written in
> mkboot.c (around lines 620-640)?

Mkboot isn't being used on SGI boxes because sash can directly boot the
ELF image produced by the kernel.

  Ralf
