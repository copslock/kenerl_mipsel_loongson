Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id EAA180669 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Feb 1998 04:14:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA18261 for linux-list; Thu, 12 Feb 1998 04:10:56 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA18256 for <linux@engr.sgi.com>; Thu, 12 Feb 1998 04:10:54 -0800
Received: from mario.gams.at (mario.gams.at [194.42.96.10]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA21199
	for <linux@engr.sgi.com>; Thu, 12 Feb 1998 04:10:51 -0800
	env-from (mla@gams.co.at)
Received: from bononunu.gams.co.at (mail.gams.co.at [193.46.232.10])
	by mario.gams.at (8.8.5/8.8.5) with ESMTP id NAA04408;
	Thu, 12 Feb 1998 13:10:06 +0100
Received: from loki.gams.co.at (loki.gams.co.at [193.46.232.130]) by bononunu.gams.co.at (8.7.1/8.7.3) with ESMTP id NAA24024; Thu, 12 Feb 1998 13:10:04 +0100
Received: from loki.gams.co.at (localhost [127.0.0.1])
	by loki.gams.co.at (8.8.5/8.8.5) with ESMTP id NAA25532;
	Thu, 12 Feb 1998 13:10:03 +0100
Message-Id: <199802121210.NAA25532@loki.gams.co.at>
To: ralf@uni-koblenz.de
cc: linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: TLB entries > 4kb 
In-reply-to: Your message of "Thu, 12 Feb 1998 05:56:48 +0100."
             <19980212055648.54198@uni-koblenz.de> 
Date: Thu, 12 Feb 1998 13:10:02 +0100
From: Michael Lausch <mla@gams.co.at>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>>>>> "r" == ralf  <ralf@uni-koblenz.de>
>>>>> wrote the following on Thu, 12 Feb 1998 05:56:48 +0100

r> Some architectures can use multiple page sizes in the TLB at the same time.
r> This would for example allow to map memory allocations > PAGE_SIZE using just
r> a single TLB entry if the circumstances are just right, thereby
r> reducing / eleminating TLB trashing.  This should improve the performance
r> for huge apps quite a bit.  Some architectures could partially get rid of
r> the sick effects of their virtual indexed primary caches as well.  All that
r> is needed for this to work is to have sufficiently large physical pages with
r> sufficient alignment at hand.

r> Has anybody ever looked into implementing that?  What architectures besides
r> MIPS could take advantage of such a feature?

The MPC860. We now have 8 MByte Page Table entries for the Kernel Address
Space and the Dual Ported RAM used to communicate with the CPM.

r>   Ralf

r> -
r> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
r> the body of a message to majordomo@vger.rutgers.edu
