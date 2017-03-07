Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 17:57:03 +0100 (CET)
Received: from resqmta-ch2-10v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:42]:41586
        "EHLO resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993894AbdCGQ4xSed9M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 17:56:53 +0100
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-10v.sys.comcast.net with SMTP
        id lIMecXDEeILPAlIPrcjZi4; Tue, 07 Mar 2017 16:56:51 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-19v.sys.comcast.net with SMTP
        id lIPpcGbaWa1xFlIPqc1QYt; Tue, 07 Mar 2017 16:56:51 +0000
Subject: Re: RFC: Proper locking tips for IRQ handlers?
To:     James Hogan <james.hogan@imgtec.com>
References: <2c6f8c8d-6380-2f0b-69be-72115e2012c7@gentoo.org>
 <20170306114038.GE2878@jhogan-linux.le.imgtec.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <f9134263-c100-d817-6634-e52d8bacb510@gentoo.org>
Date:   Tue, 7 Mar 2017 11:56:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170306114038.GE2878@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK3gVpyEdzqTeFBt5wWMemtR9BU/A47ErPmeIUiSPfwyctIWTisUVU6q8jb3rogKhRjiIDUARff0RMfsUb+jTz3V/igGw5WaZzm6BCn59wAwJdye6EHi
 4SEz6lVb91G5YaBIMNMik4Qu59V+Ob6V+6QKcMDdET7qVZsNTdv6yGf2i6Cq5bn7/CiCGs341OkuxHC4WN80tbZx1mCzTuHb3JU=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 03/06/2017 06:40, James Hogan wrote:
> Hi Joshua,
> 
> On Sat, Mar 04, 2017 at 10:17:41AM -0500, Joshua Kinard wrote:
>> I am looking for some feedback on how to improve IRQ handlers on IP30 (SGI
>> Octane).  Since switching to the use of per_cpu data structures, I've
>> apparently not needed to do any locking when handling IRQs.  However, it looks
>> like around ~Linux-4.8.x, there's some noticeable contention going on with
>> heavy disk I/O, and it's worse in 4.9 and 4.10.  Under 4.8, untar'ing a basic
>> Linux kernel source tarball completed fine, but as of 4.9/4.10, there's a
>> chance to trigger either an oops or oom killer.  While the untar operation
>> happens, I can watch the graphics console and the blinking cursor will
>> sometimes pause momentarily, which suggests contention somewhere.
>>
>> So my question is in struct irq_chip accessors like irq_ack, irq_mask,
>> irq_mask_ack, etc, should spinlocks be used prior to accessing the HEART ASIC?
>> And if so, normal spinlocks, raw spinlocks, or the irq save/restore variants?
> 
> On RT kernels spinlock_t becomes a mutex and won't work correctly with
> IRQs actually disabled for the IRQ callbacks, so raw spinlocks would be
> needed instead.

Okay, that's a really good data point to be aware of.  I haven't tried RT
kernels on any SGI systems, so I wasn't aware of that.


> To decide which variant, a good reference is:
> https://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/index.html
> in particular the cheat sheet for locking:
> https://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/c214.html

I have always found that cheat sheet table difficult to decipher.  Probably
from a lack of understanding of all the intricate ways locks can be utilized.


> (I don't know OTOH which contexts these callbacks are called from,
> definitely hard IRQ, but possibly others when registering IRQs etc).
> 
> If its only protecting access to per-CPU structures though you shouldn't
> need the spinlock part of the locks (but does it not access hardware
> registers too, or are those accesses atomic in hardware rather than
> software doing read-modify-write?). In that case you could choose to use
> the following instead of locks depending on the contexts its used in:
> 
> - spin_lock_irqsave/restore -> local_irq_save/restore +
> 				preempt_disable/enable
> - spin_lock_irq -> local_irq_disable/enable +
> 				preempt_disable/enable
> - spin_lock_bh -> local_bh_disable/enable
> - spin_lock -> preempt_disable/enable

I dumped a lot of the older locking code after learning about per_cpu and
following some of the header comments on how to properly do per_cpu reads and
writes to avoid preemption issues....not that I've tested preemption out on
these systems either.

Access to HEART is done using simple aliases to ____raw_readq (as heart_read)
and ____raw_writeq (as heart_write).  As far as I can tell, these don't do any
IRQ enabling/disabling since they're used in the places where I *think* the
local IRQs are already disabled (is there a way to check this?), however,
documentation on these versions of readq/writeq is somewhat scant, and the only
real hit on them is from 2004:

https://www.linux-mips.org/archives/linux-mips/2004-01/msg00288.html

I got rid of a lot of the direct pointer access methods like *foo |= bar; when
writing stuff back to HEART, replacing with the aliased heart_read/heart_write
methods, so that should avoid RMW issues.

That said, I'm not even 100% sure locking is the cause of this recent issue
(assuming for a moment it's not tied to my known BRIDGE/PCI issues).
CONFIG_DEBUG_LOCK_ALLOC can't be used on these platforms because the resultant
kernel is apparently too large for ARCS to stick into a "FreeMemory" area.
However, I've stripped kernels down to ~9MB with CONFIG_DEBUG_LOCK_ALLOC set
and ARCS still refuses to load it, so I suspect it's a specific section of the
ELF binary that ARCS can't load properly with that option enabled.  Even
arcload (ARCS bootloader written by Stan) can't get around it.  That's been a
major reason why I can't fully verify that I'm doing locking correctly.

--J


> Hope that helps a bit
> 
> Cheers
> James
> 
>> I've looked at the IRQ implementations for a few other MIPS boards, but because
>> each system is so unique, there's no clear consensus on the right way to do it.
>>  Octeon, uses irq_bus_lock and irq_bus_sync_unlock, along with a mutex, for
>> locking, while netlogic uses locking only during irq_enable or irq_disable, and
>> loongsoon-3 doesn't appear to employ any locking at all.  Other archs appear to
>> be a mix as well, and I'm even seeing newer constructs like the use of
>> irq_data_get_irq_chip_data() to fetch a common data structure where the
>> spinlock variable is defined.  Other systems use a global spinlock.
>>
>> Any advice would be greatly appreciated.  Thanks!
