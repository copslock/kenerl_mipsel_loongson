Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id IAA102145 for <linux-archive@neteng.engr.sgi.com>; Sat, 28 Feb 1998 08:50:00 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA25446 for linux-list; Sat, 28 Feb 1998 08:49:28 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA25441; Sat, 28 Feb 1998 08:49:26 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA05548; Sat, 28 Feb 1998 08:49:24 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id RAA09741;
	Sat, 28 Feb 1998 17:49:23 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id RAA04903; Sat, 28 Feb 1998 17:49:22 +0100
Message-ID: <19980228174921.30289@uni-koblenz.de>
Date: Sat, 28 Feb 1998 17:49:21 +0100
From: ralf@uni-koblenz.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ariel@cthulhu.engr.sgi.com, grimsy@varberg.se, linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
References: <199802280623.WAA33234@oz.engr.sgi.com> <m0y8p37-0005FsC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <m0y8p37-0005FsC@the-village.bc.nu>; from Alan Cox on Sat, Feb 28, 1998 at 04:23:41PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Feb 28, 1998 at 04:23:41PM +0000, Alan Cox wrote:

> > Alan Cox.  There have been a few more in the past, but most have
> > a real job too so they are working on this on and off...
> 
> SGIwise Im sort of stuck at the moment waiting for things to appear. If someone
> can get me/email me the PS/2 mouse docs for the indy I'll attack that if
> Miguel is still having it lock up on him

Basically the Indy PS/2 hardware is the same as on PCs, it's just that both
mouse and keyboard are using the same interrupt and we therefore need some
special magic.  When cleaning up in the keyboard driver I somehow lost the
PS/2 magic stuff that calls aux_interrupt().  Old CVS kernel versions
should have that stuff still in the keyboard code.

  Ralf
