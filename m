Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 16:25:55 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53885 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22668420AbYJ2QZs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 16:25:48 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49088e830000>; Wed, 29 Oct 2008 12:25:39 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 09:25:38 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 09:25:37 -0700
Message-ID: <49088E81.7080604@caviumnetworks.com>
Date:	Wed, 29 Oct 2008 09:25:37 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 04/36] Add Cavium OCTEON processor support files to	arch/mips/mm.
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <20081029160710.GB26256@linux-mips.org>
In-Reply-To: <20081029160710.GB26256@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2008 16:25:37.0993 (UTC) FILETIME=[FA34DB90:01C939E2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 27, 2008 at 05:02:36PM -0700, David Daney wrote:
> 
>>  arch/mips/mm/c-octeon.c |  309 +++++++++++++++++++++++++++++++++++++++++++++++
>>  arch/mips/mm/cex-oct.S  |   70 +++++++++++
>>  2 files changed, 379 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/mips/mm/c-octeon.c
>>  create mode 100644 arch/mips/mm/cex-oct.S
>>
>> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
>> new file mode 100644
>> index 0000000..6c96c1a
>> --- /dev/null
>> +++ b/arch/mips/mm/c-octeon.c
>> @@ -0,0 +1,309 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2005-2007 Cavium Networks
>> + */
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/sched.h>
>> +#include <linux/mm.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cpu.h>
>> +#include <linux/io.h>
>> +
>> +#include <asm/bcache.h>
>> +#include <asm/bootinfo.h>
>> +#include <asm/cacheops.h>
>> +#include <asm/cpu-features.h>
>> +#include <asm/page.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/r4kcache.h>
>> +#include <asm/system.h>
>> +#include <asm/mmu_context.h>
>> +#include <asm/war.h>
>> +#include "../cavium-octeon/hal.h"
> 
> You probably want to move that header to
> arch/mips/include/asm/mach-cavium-octeon so you can get away without the
> "../" kludge.
> 

Right, I was thinking the same thing.  Consider it done.


>> +static void octeon_flush_icache_all_cores(struct vm_area_struct *vma)
>> +{
>> +	extern struct plat_smp_ops *mp_ops;	/* private */
>> +#ifdef CONFIG_SMP
>> +	int i;
>> +	int cpu;
>> +#endif
>> +
>> +	preempt_disable();
>> +#ifdef CONFIG_SMP
>> +	cpu = smp_processor_id();
>> +#endif
>> +	mb();
>> +
>> +	/* If we have a vma structure, we only need to worry about cores it
>> +	   has been used on */
>> +	if (vma) {
>> +#ifdef CONFIG_SMP
>> +		for (i = 0; i < NR_CPUS; i++)
>> +			if (cpu_isset(i, vma->vm_mm->cpu_vm_mask) && i != cpu)
>> +				mp_ops->send_ipi_single(i, SMP_ICACHE_FLUSH);
>> +#endif
>> +		asm volatile ("synci 0($0)\n");
>> +	} else {
>> +		/* No extra info available. Flush the icache on all cores that
>> +		   are online */
>> +#ifdef CONFIG_SMP
>> +		for (i = 0; i < NR_CPUS; i++)
>> +			if (cpu_online(i) && i != cpu)
>> +				mp_ops->send_ipi_single(i, SMP_ICACHE_FLUSH);
>> +#endif
>> +		asm volatile ("synci 0($0)\n");
>> +	}
> 
> You can avoid the entire #ifdef CONFIG_SMP mess with for_each_online_cpu().
> 

I already rewrote that whole part, but...


> For some workloads IPIs can be performance limiting.  You can avoid them
> entirely if the mm that is being flush out of the CPU is not active on the
> remote processor by simply setting the remote's context for that mm to
> zero.  This means the remote CPU will allocate a new context.  That's a
> matter of a few instructions as long as the remote's ASID counter doesn't
> overflow that is 255 out of 256 times.
> 
> The price to pay is to accept that both the vtag'ed I-cache and the TLB
> of the remote need to be reloaded which seems relativly harmless compared
> to the alternatives.
> 

... I will investigate doing this instead.


>> +/**
>> + * Flush the icache for a trampoline. These are used for interrupt
>> + * and exception hooking.
>> + *
>> + * @param addr   Address to flush
>> + */
>> +static void octeon_flush_cache_sigtramp(unsigned long addr)
>> +{
>> +	/* Only flush trampolines on the current core */
>> +	mb();
>> +	asm volatile ("synci 0(%0)\n" : : "r" (addr));
>> +}
> 
> Bug - unless Cavium SYNCI syncs all cores?

It doesn't.

>  The probability is not so high
> for typical apps but it's entirely possibly that on a preemptable kernel
> the thread that wrote the trampoline code gets rescheduled to another
> CPU before the flush is executed.  Or after the SYNCI happened on the one
> core the thread is rescheduled to another CPU which then may try to
> return with an inconsistent I-cache.  Boom.


This is the problem I mentioned yesterday on IRC.  I had come to the 
same conclusion and think we need to invalidate the icache on all cores 
here.

The real solution to this problem is to place the signal trampolines in 
a VDSO.  But that is a project for another day.

> 
>> +/**
>> + * Flush a specific page of a vma
>> + *
>> + * @param vma    VMA to flush page for
>> + * @param page   Page to flush
>> + * @param pfn
>> + */
>> +static void octeon_flush_cache_page(struct vm_area_struct *vma,
>> +				    unsigned long page, unsigned long pfn)
>> +{
>> +	if (vma->vm_flags & (VM_EXEC|VM_EXECUTABLE))
>> +		octeon_flush_icache_all_cores(vma);
> 
> Drop all references to VM_EXECUTABLE - this flag is dead.  At this low
> level all that matters is VM_EXEC really.

Consider it done.

David Daney
