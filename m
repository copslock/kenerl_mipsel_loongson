Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA92525 for <linux-archive@neteng.engr.sgi.com>; Sun, 2 May 1999 11:55:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA64515
	for linux-list;
	Sun, 2 May 1999 11:53:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA14376
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 May 1999 11:53:51 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup251-1-97.swipnet.se [130.244.251.97]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06781
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 May 1999 14:53:49 -0400 (EDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10e1N5-003LodC; Sun, 2 May 1999 20:53:47 +0200 (CEST)
Date: Sun, 2 May 1999 20:53:47 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: "Andrew R. Baker" <andrewb@uab.edu>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Indigo2 patch
Message-ID: <19990502205347.A7346@thepuffingroup.com>
Mail-Followup-To: "Andrew R. Baker" <andrewb@uab.edu>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <Pine.LNX.3.96.990502111429.14447B-200000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <Pine.LNX.3.96.990502111429.14447B-200000@mdk187.tucc.uab.edu>; from Andrew R. Baker on Sun, May 02, 1999 at 11:24:54AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> OK, since this is my first time making a patch I am not sure I got
> everything quite right.  This will let people with an Indigo2 actually
> boot into Linux.  However, they probably won't be able to do much

Cool!

> thereafter (I get the kernel to die while doing a 'cat README' in the root
> directory).  Unfortunately, this won't print the console boot messages to
> the screen either.  To do this, I replaced the printk code in
> kernel/printk.c with the printf code in arch/mips/arc/printf.c.  I'm sure
> there is a better way, but I haven't found it yet.  These were made

Yes, there's a better way. A PROM console can be implemented. I have hacked some
code for this PROM console for this purpose. I can't get it to open the initial
console though. I'll send it to you, maybe you have time to figure out what's
wrong...

> -LINKFLAGS	= -static -N
> +# having -N in LINKFLAGS causes my Indigo2 not to boot
> +LINKFLAGS	= -static

This is a problem with the cross linker and not with the kernel itself, it's the
same for Indy's. The code in the CVS tree should remain as it is.

- Ulf
