Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA28499 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Oct 1998 14:14:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA20074
	for linux-list;
	Thu, 29 Oct 1998 14:13:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA93005
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 29 Oct 1998 14:13:31 -0800 (PST)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06840
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Oct 1998 14:13:30 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zZ0Je-0027ydC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 29 Oct 1998 23:13:14 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zZ0JW-002PAwC; Thu, 29 Oct 98 23:13 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA03794;
	Thu, 29 Oct 1998 23:10:09 +0100
Message-ID: <19981029231009.A3756@alpha.franken.de>
Date: Thu, 29 Oct 1998 23:10:09 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ulf Carlsson <ulfc@bun.falkenberg.se>, ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: HAL2 interrupt
References: <19981028005901.C23849@zigzegv.ml.org> <19981028232652.A2587@alpha.franken.de> <19981029111211.B28553@zigzegv.ml.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19981029111211.B28553@zigzegv.ml.org>; from Ulf Carlsson on Thu, Oct 29, 1998 at 11:12:11AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Oct 29, 1998 at 11:12:11AM +0100, Ulf Carlsson wrote:
> The problem is that the sgiseeq and the sgiwd93 use HPC DMA as well, but they're

yes, but they aren't using PBUS DMA channels, because they aren't connected
to the PBUS.

> sharing local interrupt 0 (MIPS IRQ 2), and using some status register to
> differentiate them. If I were writing a sgiwd93 driver or a sgiseeq driver, my
> first guess would have been that they were using the SGINT_HPCDMA interrupts.

SCSI and ethernet are special HPC devices, so they get handled in a different
way.

> Well, looks like I'm out of luck, I'll do some trial & error.

try interrupt 12, which should be the HPC3 interrupt (sgint23.h). After
getting an HPC3 interrupt you have to look in HPC3 register istat0 and 
istat1 for the interrupt source. I guess DaveM wanted to map these
interrupt sources to SGINT_HPCDMA, but never got to implement it.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
