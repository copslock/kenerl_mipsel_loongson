Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA48457 for <linux-archive@neteng.engr.sgi.com>; Tue, 21 Jul 1998 10:55:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA50399
	for linux-list;
	Tue, 21 Jul 1998 10:55:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA32617;
	Tue, 21 Jul 1998 10:55:08 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA22268; Tue, 21 Jul 1998 10:54:48 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id TAA27517;
	Tue, 21 Jul 1998 19:54:46 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id TAA24121; Tue, 21 Jul 1998 19:54:43 +0200
Message-ID: <19980721195442.00647@uni-koblenz.de>
Date: Tue, 21 Jul 1998 19:54:42 +0200
From: ralf@uni-koblenz.de
To: eak@detroit.sgi.com
Cc: Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: Xwindows status?
References: <Pine.LNX.3.95.980721093249.5677D-100000@thebrain> <35B4D431.F77FB01B@detroit.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <35B4D431.F77FB01B@detroit.sgi.com>; from Eric Kimminau on Tue, Jul 21, 1998 at 01:47:29PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jul 21, 1998 at 01:47:29PM -0400, Eric Kimminau wrote:

> Good morning!
> 
> We have wonderful news! linux.detroit.sgi.com is now online!

Cool.

> Obviously we are missing the actual XServer binary.
> ANy chance I can get it from someone?

Mike for shure won't mind giving you one as soon as it's finished :-)

Since RedHat's XFree packages are made up that way we already ship
all the environment around the actual X server, just not the server
itself.  Except Xfvb, Xnest and XF68_FBcon, the later cannot be used
on the Indy's hardware.

  Ralf
