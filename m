Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA31280 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Oct 1998 15:16:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA37815
	for linux-list;
	Thu, 15 Oct 1998 15:15:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA07671
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Oct 1998 15:15:48 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (dialup148-3-41.swipnet.se [130.244.148.169]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08758
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Oct 1998 15:15:46 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: by zigzegv.ml.org
	via sendmail from stdin
	id <m0zTvht-000w6YC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Fri, 16 Oct 1998 00:17:17 +0200 (CEST) 
Message-ID: <19981016001717.B2072@zigzegv.ml.org>
Date: Fri, 16 Oct 1998 00:17:17 +0200
From: Ulf Carlsson <grim@zigzegv.ml.org>
To: Jeff Coffin <jcoffin@sv.usweb.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
References: <m3ww618s88.fsf@lil.sv.usweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <m3ww618s88.fsf@lil.sv.usweb.com>; from Jeff Coffin on Thu, Oct 15, 1998 at 01:50:31PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello,

> Last night I got the HardHat kernel to boot via the bootp method
> described in the Howto and, as expected from the experiences of
> Richard Hartensveld, it hung looking for a console.  I then grabbed
> newer kernels (2.1.116 and 2.1.121) from the /pub/test on the ftp
> server and attmepted to get them loaded by the same mechanism, but
> both of them hang after loading via tftp.

It *should* find an initial console if you have mounted the root filesystem from
the hardhat CD correctly. 

You can probably install hardhat on a i386 box in your local network if you
want, and boot directly into an already installed hardhat via nfs-root. That
hardhat default installer is _very_ annoying, it crashes all the time.. (signal
11, out of memory etc..), I don't know if this would solve your problems - but
it helped me... :)
Give the --root <rootdir> option to rpm, and install the needed rpms from the cd

> I don't know where to go from here, so I'm looking for ideas.  Hinv
> and the boot log from the hardhat kernel boot are below.
> 
> I'm thinking about removing the gfx board entirely and seeing if that
> has any effect, will that do me any good?

It would probably not make much difference, "Warning: unable to open an initial
console" isn't caused by a gfx board neither an old kernel, but from an
incorrect /dev/console.

I'm currently running hardhat diskless, I'm only using the IRIX harddrive when
I boot (the bootp command is loaded from the harddrive).

- Ulf
