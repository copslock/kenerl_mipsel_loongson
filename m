Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Sep 2004 08:23:48 +0100 (BST)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:34521 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8224941AbUIOHXn>; Wed, 15 Sep 2004 08:23:43 +0100
Received: by the-doors.enix.org (Postfix, from userid 1105)
	id 269991F041; Wed, 15 Sep 2004 09:23:37 +0200 (CEST)
Date: Wed, 15 Sep 2004 09:23:37 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: linux-mips@linux-mips.org
Cc: mentre@tcl.ite.mee.com
Subject: Questions regarding MIPS platforms boot process
Message-ID: <20040915072337.GX6242@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <thomas@the-doors.enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

Hello,

I'm currently trying to port Linux 2.6 to a MIPS platform which is very
similar to the Jaguar ATX platform, so I started from this code. I have
a few questions concerning this code.

1) Wired TLB entries and ioremap()

In the file arch/mips/momentum/jaguar_atx/setup.c, the
momenco_jaguar_atx_setup() function calls the wire_stupidity_into_tlb()
function to hard-wire entries into the TLB. These entries allows to
access the Marvell registers space (at 0xf4000000). So, this is done in
the early stages of the initialization.

Then, later, the per_cpu_mappings() function is called, through the
arch_initcall mecanism. This function calls ioremap() to map in virtual
memory the Marvell registers space.

At the beginning, I did not understand why both (hard-wired TLB entry
+ mapping in virtual space through ioremap()) were needed, but after
reflexion and discussion with collegues, we found out a possible
explanation. I just wanted to know if it was true or not.

At the very first stages of the initialization (during the
momenco_jaguar_atx_setup() function for example), paging is not
initialized, so we cannot use ioremap(). But we still want to be able to
talk with the Marvell, so the only solution is to wire an entry in the
TLB.

Then, later on, once everything has been set up (including paging), we
do not need anymore this wired entry, which is deleted in the
per_cpu_mappings() function through the call of the
local_flush_tlb_all() function. The Marvell registers space is then
ioremap'ed in the address, and so is still accessible (because paging is
now enabled).

Is it the right explanation ?

2) Mips_hpt_frequency

I'm not sure whether my board_time_init() function should set
mips_hpt_frequency or not. In arch/mips/kernel/time.c, it is said that :

 *      b) (optional) calibrate and set the mips_hpt_frequency
 *	    (only needed if you intended to use fixed_rate_gettimeoffset
 *	     or use cpu counter as timer interrupt source)

So it doesn't seem to be mandatory, but actually I do not understand
clearly the two cases for which setting mips_hpt_frequency is mandatory.
I don't think I want to use fixed_rate_gettimeoffset, but I'm not sure
with the second usage.

When I read the code of arch/mips/kernel/time.c, function time_init()
around line 701, I can see that if no value has been set to
mips_hpt_frequency, then it is computed by the calibrate_hpt(). So, when
is it needed to set it ?

FYI, the platform I'm working on doesn't have any external timer source.

What's the exact use of the mips_hpt_frequency ? Should I set it or not
?

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org 
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7
