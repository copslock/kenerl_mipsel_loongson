Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA54440 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Oct 1998 00:10:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA10219
	for linux-list;
	Thu, 29 Oct 1998 00:09:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA77205
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 29 Oct 1998 00:09:28 -0800 (PST)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA00452
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Oct 1998 00:09:26 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zYn90-00284aC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 29 Oct 1998 09:09:22 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zYe7H-002P7SC; Wed, 28 Oct 98 23:30 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA02594;
	Wed, 28 Oct 1998 23:26:53 +0100
Message-ID: <19981028232652.A2587@alpha.franken.de>
Date: Wed, 28 Oct 1998 23:26:52 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ulf Carlsson <ulfc@bun.falkenberg.se>, ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: HAL2 interrupt
References: <19981028005901.C23849@zigzegv.ml.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19981028005901.C23849@zigzegv.ml.org>; from Ulf Carlsson on Wed, Oct 28, 1998 at 12:59:01AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Oct 28, 1998 at 12:59:01AM +0100, Ulf Carlsson wrote:
> Now I'm asking again, do you know which interrupt number I should request for
> the PBUS DMA:s. I can't handle the interrupts correctly without the knowledge of

for me it looks like SGINT_HPCDMA should be the first PBUS DMA interrupt.
But looking further into the indyIRQ.S and indy_int.c indicates, that these
interrupts aren't implemented, yet.

> It would be nice if you even explained *how* you know..

use the source Luke.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
