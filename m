Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA81878 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Mar 1999 10:14:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA03027
	for linux-list;
	Fri, 12 Mar 1999 10:12:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA18002;
	Fri, 12 Mar 1999 10:12:48 -0800 (PST)
	mail_from (miguel@metropolis.nuclecu.unam.mx)
Received: from metropolis.nuclecu.unam.mx (metropolis.nuclecu.unam.mx [132.248.29.92]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA12456; Fri, 12 Mar 1999 10:12:25 -0800 (PST)
	mail_from (miguel@metropolis.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by metropolis.nuclecu.unam.mx (8.8.7/8.8.7) id MAA30851;
	Fri, 12 Mar 1999 12:14:51 -0600
Date: Fri, 12 Mar 1999 12:14:51 -0600
Message-Id: <199903121814.MAA30851@metropolis.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: adelton@informatics.muni.cz
CC: ariel@cthulhu.engr.sgi.com, darkaeon@cubicsky.com,
        linux@cthulhu.engr.sgi.com
In-reply-to: <19990312111717.A3024@aisa.fi.muni.cz> (message from Honza
	Pazdziora on Fri, 12 Mar 1999 11:17:17 +0100)
Subject: Re: Indigo2 & Linux
X-FileLength: are infinite where infinity is set to 255 characters
References: <36E85AC2.25F7C9B0@kotetsu.cubicsky.com> <199903112224.OAA54631@oz.engr.sgi.com> <19990312111717.A3024@aisa.fi.muni.cz>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> OK, but do we have a code that has the graphics dealing done (to
> a certain point)? Where could it be found? I'd like to have a look and
> maybe move on with the development.

Which part are you interested in?  The kernel support or the X
server?

The kernel support is integrated.  You just need to setup an IRIX
emulation environment (/usr/emul/irix perhaps?  I forget) and the
proper devices used by the X server in /dev and you should be able to
launch the X server.

Not every client hangs the kernel, but xterm and emacs notably do it
(run them on a different machine to eliminate a variable).

Miguel.
