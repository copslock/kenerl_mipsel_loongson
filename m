Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA232757 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 15:30:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA20477 for linux-list; Mon, 24 Nov 1997 15:26:20 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA20448 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 15:26:09 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA08039
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 15:26:06 -0800
	env-from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ralf@pmport-04.uni-koblenz.de [141.26.249.4])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA02120
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Nov 1997 00:26:02 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA07414;
	Tue, 25 Nov 1997 00:22:31 +0100
Message-ID: <19971125002231.49580@lappi.waldorf-gmbh.de>
Date: Tue, 25 Nov 1997 00:22:31 +0100
From: ralf@uni-koblenz.de
To: linux-mips@fnet.fr
Cc: "David S. Miller" <davem@dm.cobaltmicro.com>, alan@lxorguk.ukuu.org.uk,
        linux@cthulhu.engr.sgi.com
Subject: Re: Libc in CVS
References: <199711242135.NAA00677@dm.cobaltmicro.com> <Pine.LNX.3.95.971124165709.27739C-100000@lacrosse.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.95.971124165709.27739C-100000@lacrosse.redhat.com>; from Erik Troan on Mon, Nov 24, 1997 at 04:58:22PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Nov 24, 1997 at 04:58:22PM -0500, Erik Troan wrote:
> > That was a nice thing back in the pre-glibc days.  But since so many
> > static binaries (including RPM) pull in the NIS stuff dynamically via
> > dlopen() due to how GLIBC works, your ass will no longer get saved the
> > way it used to.
> 
> At least you can install the packages though. At the very worst, 
> getpwnam() will fail and RPM will use root.root for all of the files,
> but at least they will be there. That's surely better then not being
> able to install packages at all.

I just checked mount(8), it's a shared binary.  I guess only the fewest
Redhat installations it is possible to access the packages without using
nss services or mount.

Aside, if everything gets installed as root.root in absence of the nss
functionality this open a theoretical security problem for some packages.

  Ralf
