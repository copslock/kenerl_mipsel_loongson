Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA552028 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Jan 1998 16:35:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA11646 for linux-list; Thu, 29 Jan 1998 16:32:51 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA11636 for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jan 1998 16:32:48 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA20554
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jan 1998 16:32:45 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA19469
	for <linux@cthulhu.engr.sgi.com>; Fri, 30 Jan 1998 01:32:32 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id UAA08902;
	Wed, 28 Jan 1998 20:44:23 +0100
Message-ID: <19980128204307.61681@uni-koblenz.de>
Date: Wed, 28 Jan 1998 20:43:07 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Modules...
References: <Pine.LNX.3.95.980127194019.32572O-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980127194019.32572O-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Jan 27, 1998 at 07:41:40PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 27, 1998 at 07:41:40PM -0500, Alex deVries wrote:

> How unpleasant... while trying to load cdrom.o, I got:
> [insmod:411] Illegal instruction at c000ca34 ra=c0006a3c
> 
> a couple of million times. Ideas?

Not really.  Your bugreport is missing a lot of important context.  I
might be able to help you much better if you provide a bit more
information like

 - the System.map from the kernel map
 - the kernel version
 - your .config kernel configuration
 - did you load any modules before cdrom.o?  If yes which ones?  Please
   send me a dump of /proc/modules, and /proc/ksyms.

Thanks,

  Ralf
