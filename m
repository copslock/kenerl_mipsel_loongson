Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA96491 for <linux-archive@neteng.engr.sgi.com>; Thu, 5 Mar 1998 14:08:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA862660 for linux-list; Thu, 5 Mar 1998 14:08:09 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA882895 for <linux@cthulhu.engr.sgi.com>; Thu, 5 Mar 1998 14:08:07 -0800 (PST)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA27393
	for <linux@cthulhu.engr.sgi.com>; Thu, 5 Mar 1998 14:08:06 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yAio7-0027f4C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 5 Mar 1998 23:08:03 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yAinu-002OyQC; Thu, 5 Mar 98 23:07 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA02711;
	Thu, 5 Mar 1998 22:23:09 +0100
Message-ID: <19980305222309.52959@alpha.franken.de>
Date: Thu, 5 Mar 1998 22:23:09 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: ESP driver changes
References: <19980304095356.13782@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980304095356.13782@uni-koblenz.de>; from ralf@uni-koblenz.de on Wed, Mar 04, 1998 at 09:53:56AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 04, 1998 at 09:53:56AM +0100, ralf@uni-koblenz.de wrote:
> what is the status of your ESP driver changes?  Can we eventually merge
> them back to Vger / Linus?

the version in our CVS is tested on my mips machine and on my SS2 clone.
The only open issue with the ESP driver is using it as a module, which
I didn't try on neither platform. Another problem is to bring the scsi
layer up to date as there have been some changes during 2.1.8something,
which also affects the low level drivers.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
