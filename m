Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA71810 for <linux-archive@neteng.engr.sgi.com>; Fri, 19 Mar 1999 14:57:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA18698
	for linux-list;
	Fri, 19 Mar 1999 14:56:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA52898
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 19 Mar 1999 14:56:29 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA02028
	for <linux@cthulhu.engr.sgi.com>; Fri, 19 Mar 1999 17:56:26 -0500 (EST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10O8CI-0027UOC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 19 Mar 1999 23:56:58 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10O8Bd-002Oo8C; Fri, 19 Mar 99 23:56 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA02545;
	Fri, 19 Mar 1999 22:26:18 +0100
Message-ID: <19990319222618.A2527@alpha.franken.de>
Date: Fri, 19 Mar 1999 22:26:18 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Greg Moeller <gkm@gawd.mb.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Strange bootp behavior.
References: <19990318225705.A3281@alpha.franken.de> <m10Nm5S-000VJlC@ilsa.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <m10Nm5S-000VJlC@ilsa.franken.de>; from Greg Moeller on Thu, Mar 18, 1999 at 05:20:16PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Mar 18, 1999 at 05:20:16PM -0600, Greg Moeller wrote:
> Broke printenv:
> SystemPartition=bootp():/
> OSLoader=vmlinux

this one didn't work for me at all, I had to change it to
SystemPartition=bootp(). With this it works without problems.

I see in your boot messages, that on your machine the freed prom
memory is higher than on my machine. Ulf Carlson needed to disable
the prom memory freeing to get his kernel working. So I'm pretty
sure, there something wrong with it. I've disabled this feature
in the current CVS version. Please try it (the updated file is 
arch/mips/arc/memory.c).

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
