Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id DAA128257 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 03:28:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA05759 for linux-list; Mon, 24 Nov 1997 03:21:49 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA05742 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 03:21:43 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA27561
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 03:21:41 -0800
	env-from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ralf@pmport-22.uni-koblenz.de [141.26.249.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA19975
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Nov 1997 12:21:39 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id MAA13129;
	Mon, 24 Nov 1997 12:05:49 +0100
Message-ID: <19971124120549.01585@lappi.waldorf-gmbh.de>
Date: Mon, 24 Nov 1997 12:05:49 +0100
From: ralf@uni-koblenz.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Libc in CVS
References: <19971124054108.44804@lappi.waldorf-gmbh.de> <m0xZv6B-0005FtC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <m0xZv6B-0005FtC@lightning.swansea.linux.org.uk>; from Alan Cox on Mon, Nov 24, 1997 at 09:46:35AM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Nov 24, 1997 at 09:46:35AM +0000, Alan Cox wrote:
> > Given that this opens the way to useable native X libraries, which makes
> > building a large number of other RPM packages possible, these patches
> > are quite a breakthough.
> 
> With luck it'll also fix the rpm-2.4.8 core dump bug which seems to be
> bad linking.

My rpm has never dumped core but it was complaining about nonexisting
users while creating the binary rpm file even though the user was
existing thus failing to build.  That rpm problem is fixed.

> I'll turn the RPM factory back on

All the source RPM packages on linus are known to build and work for
little endian targets.  Some of them, for example ncompress, have special
modifications to support big endian targets.

  Ralf
