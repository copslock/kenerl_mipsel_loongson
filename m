Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id IAA141033 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 08:01:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA12610 for linux-list; Mon, 24 Nov 1997 07:59:25 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA12536 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 07:59:13 -0800
Received: from lacrosse.redhat.com (lacrosse.redhat.com [207.175.42.154]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA18496
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 07:59:11 -0800
	env-from (ewt@redhat.com)
Received: from localhost (ewt@localhost)
	by lacrosse.redhat.com (8.8.5/8.8.7) with SMTP id KAA08711;
	Mon, 24 Nov 1997 10:55:25 -0500
Date: Mon, 24 Nov 1997 10:55:25 -0500 (EST)
From: Erik Troan <ewt@redhat.com>
To: linux-mips@fnet.fr
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@cthulhu.engr.sgi.com
Subject: Re: Libc in CVS
In-Reply-To: <19971124141804.17724@lappi.waldorf-gmbh.de>
Message-ID: <Pine.LNX.3.95.971124105430.7590F-100000@lacrosse.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 24 Nov 1997 ralf@lappi.waldorf-gmbh.de wrote:

> For rpm the trick is easy, just don't use a static linked binary.
> Unfortunately the Redhat guys seem to think static binaries are a good
> idea and install a static rpm by default.  Which it is not, not even
> without a buggy dynamic linker.

A static RPM has saved my ass *many* times, and it would irresponsible
for us not to ship it static. Glibc ought to be able to generate
static binaries. If it can't, it's broken.

Erik

-------------------------------------------------------------------------------
|       "For the next two hours, VH1 will be filled with foul-mouthed,        |
|          crossdressing Australians. Viewer discretion is advised."          |
|                                                                             |
|       Erik Troan   =   ewt@redhat.com     =    ewt@sunsite.unc.edu          |
