Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA513177 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Jan 1998 13:22:26 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA06960 for linux-list; Thu, 29 Jan 1998 13:18:16 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA06833 for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jan 1998 13:18:01 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA24738
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jan 1998 13:18:00 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id WAA04146;
	Thu, 29 Jan 1998 22:17:52 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id WAA08678; Thu, 29 Jan 1998 22:17:50 +0100
Message-ID: <19980129221750.18001@uni-koblenz.de>
Date: Thu, 29 Jan 1998 22:17:50 +0100
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: strange problem with my oli M700
References: <19980129212705.29618@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <19980129212705.29618@alpha.franken.de>; from Thomas Bogendoerfer on Thu, Jan 29, 1998 at 09:27:05PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jan 29, 1998 at 09:27:05PM +0100, Thomas Bogendoerfer wrote:

> I'm trying to read the firmware prom of my Olivetti M700 (Magnum 4000 clone).
> When access the address 0x9fc00000 (which is the KSEG0 address of the prom)
> the box freezes immidiately. Does anybody know why ? And how could I access
> the prom otherwise ?

Did you try uncached accesses via KSEG1?  I wouldn't wonder if the used
PROMs can't cope with the bursts generated for filling a cacheline.

  Ralf
