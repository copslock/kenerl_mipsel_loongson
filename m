Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA197490 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 14:03:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA20141 for linux-list; Mon, 24 Nov 1997 14:01:56 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA20022 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 14:01:46 -0800
Received: from lacrosse.redhat.com (lacrosse.redhat.com [207.175.42.154]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA11947
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 14:01:43 -0800
	env-from (ewt@redhat.com)
Received: from localhost (ewt@localhost)
	by lacrosse.redhat.com (8.8.5/8.8.7) with SMTP id QAA27888;
	Mon, 24 Nov 1997 16:58:22 -0500
Date: Mon, 24 Nov 1997 16:58:22 -0500 (EST)
From: Erik Troan <ewt@redhat.com>
To: "David S. Miller" <davem@dm.cobaltmicro.com>
cc: linux-mips@fnet.fr, alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
Subject: Re: Libc in CVS
In-Reply-To: <199711242135.NAA00677@dm.cobaltmicro.com>
Message-ID: <Pine.LNX.3.95.971124165709.27739C-100000@lacrosse.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 24 Nov 1997, David S. Miller wrote:

> That was a nice thing back in the pre-glibc days.  But since so many
> static binaries (including RPM) pull in the NIS stuff dynamically via
> dlopen() due to how GLIBC works, your ass will no longer get saved the
> way it used to.

At least you can install the packages though. At the very worst, 
getpwnam() will fail and RPM will use root.root for all of the files,
but at least they will be there. That's surely better then not being
able to install packages at all.

Erik

-------------------------------------------------------------------------------
|       "For the next two hours, VH1 will be filled with foul-mouthed,        |
|          crossdressing Australians. Viewer discretion is advised."          |
|                                                                             |
|       Erik Troan   =   ewt@redhat.com     =    ewt@sunsite.unc.edu          |
