Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 14:10:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54492 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012934AbaKRNKRaPHaQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 14:10:17 +0100
Date:   Tue, 18 Nov 2014 13:10:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP Help
In-Reply-To: <546B3D9C.6000104@gentoo.org>
Message-ID: <alpine.LFD.2.11.1411181255420.4773@eddie.linux-mips.org>
References: <5457187D.6030708@gentoo.org> <54607499.2070806@gentoo.org> <546B11C0.90805@gentoo.org> <alpine.LFD.2.11.1411180946130.4773@eddie.linux-mips.org> <546B3D9C.6000104@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 18 Nov 2014, Joshua Kinard wrote:

> >> CPU: 0 PID: 54 Comm: grep Not tainted 3.18.0-rc4 #194
> >> task: a800000059b80000 ti: a8000000595c4000 task.ti: a8000000595c4000
> >> $ 0   : 0000000000000000 ffffffff9004fce0 ffffffffffffffff ffffffffffffffff
> >> $ 4   : 0000000077d809a0 0000000000000000 ffffffffffffffff ffffffffffffffff
> >> $ 8   : 0000000000440f14 0000000000439bdc 0000000000000058 0000000000000000
> >> $12   : 0000000000000000 a800000059b88aa0 a8000000200d22d0 001c450400000018
> >> $16   : 0000000077d809a0 0000000077e3f000 0000000000000000 0000000000000000
> >> $20   : 0000000077d803b4 0000000000000001 0000000077d82604 000000007ff808f8
> >> $24   : 0018460400000000 0000000077c7aa90
> >> $28   : 0000000077d88e10 000000007ff807c0 000000007ff807c0 0000000077c68bdc
> >> Hi    : 0000000000061170
> >> Lo    : 00000000000205d0
> >> epc   : 0000000077c7ab00 0x77c7ab00
> >>     Not tainted
> >> ra    : 0000000077c68bdc 0x77c68bdc
> >> Status: 8004fcf3    KX SX UX KERNEL EXL IE
[...]
> This is an o32 userland.  So that means, given 64-bit wide registers, o32 is
> going to stuff two 32-bit quantities into them?  I have an n32 chroot on a
> different partition, but I haven't tried it w/ CONFIG_SMP yet.

 No, user registers have to be treated as 32-bit, that is sign-extended 
from bit #31 (bits 63:32 are a copy of bit #31).  Using 32-bit operations 
only guarantees that, e.g. when you load a register from its stack slot 
using the 32-bit LW instruction, then on a 64-bit processor it will get 
sign-extended in the hardware register from bit #31 through to bit #63.  

 Of course an o32 bit program does not see it, it sees the environment as 
it would on a 32-bit processor as it is supposed to run the same on a true 
32-bit processor.  Well, strictly speaking this is not completely true on 
Linux, for that to be the case the UX bit you see set in the Status 
register dumped above would have to be cleared, but this is a historical 
artefact and nobody has had the incentive to clean this up yet (in a 
reference environment you want UX clear for o32, UX set for n64 and PX set 
for n32 where available, otherwise UX set).  Clearing the UX bit disables 
all the 64-bit instructions in the user mode making a user program unable 
to see or modify the upper 32 bits of any general register (they're still 
sign-extended automatically).

 Please do yourself a favour and read a good MIPS architecture book; 
Dominic Sweetman's "See MIPS Run" would be my recommendation and its 
second edition has some focus on Linux too that might help.  Without a 
good understanding of the architecture you'll be having a very, very hard 
time debugging such low-level issues.

  Maciej
