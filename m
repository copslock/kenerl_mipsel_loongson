Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 16:07:18 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:14030 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22666337AbYJ2QHQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 16:07:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9TG7C85024377;
	Wed, 29 Oct 2008 16:07:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9TG7AiP024375;
	Wed, 29 Oct 2008 16:07:10 GMT
Date:	Wed, 29 Oct 2008 16:07:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 04/36] Add Cavium OCTEON processor support files to
	arch/mips/mm.
Message-ID: <20081029160710.GB26256@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:02:36PM -0700, David Daney wrote:

>  arch/mips/mm/c-octeon.c |  309 +++++++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/mm/cex-oct.S  |   70 +++++++++++
>  2 files changed, 379 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/mm/c-octeon.c
>  create mode 100644 arch/mips/mm/cex-oct.S
> 
> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
> new file mode 100644
> index 0000000..6c96c1a
> --- /dev/null
> +++ b/arch/mips/mm/c-octeon.c
> @@ -0,0 +1,309 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2005-2007 Cavium Networks
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/bitops.h>
> +#include <linux/cpu.h>
> +#include <linux/io.h>
> +
> +#include <asm/bcache.h>
> +#include <asm/bootinfo.h>
> +#include <asm/cacheops.h>
> +#include <asm/cpu-features.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/r4kcache.h>
> +#include <asm/system.h>
> +#include <asm/mmu_context.h>
> +#include <asm/war.h>
> +#include "../cavium-octeon/hal.h"

You probably want to move that header to
arch/mips/include/asm/mach-cavium-octeon so you can get away without the
"../" kludge.

> +static void octeon_flush_icache_all_cores(struct vm_area_struct *vma)
> +{
> +	extern struct plat_smp_ops *mp_ops;	/* private */
> +#ifdef CONFIG_SMP
> +	int i;
> +	int cpu;
> +#endif
> +
> +	preempt_disable();
> +#ifdef CONFIG_SMP
> +	cpu = smp_processor_id();
> +#endif
> +	mb();
> +
> +	/* If we have a vma structure, we only need to worry about cores it
> +	   has been used on */
> +	if (vma) {
> +#ifdef CONFIG_SMP
> +		for (i = 0; i < NR_CPUS; i++)
> +			if (cpu_isset(i, vma->vm_mm->cpu_vm_mask) && i != cpu)
> +				mp_ops->send_ipi_single(i, SMP_ICACHE_FLUSH);
> +#endif
> +		asm volatile ("synci 0($0)\n");
> +	} else {
> +		/* No extra info available. Flush the icache on all cores that
> +		   are online */
> +#ifdef CONFIG_SMP
> +		for (i = 0; i < NR_CPUS; i++)
> +			if (cpu_online(i) && i != cpu)
> +				mp_ops->send_ipi_single(i, SMP_ICACHE_FLUSH);
> +#endif
> +		asm volatile ("synci 0($0)\n");
> +	}

You can avoid the entire #ifdef CONFIG_SMP mess with for_each_online_cpu().

For some workloads IPIs can be performance limiting.  You can avoid them
entirely if the mm that is being flush out of the CPU is not active on the
remote processor by simply setting the remote's context for that mm to
zero.  This means the remote CPU will allocate a new context.  That's a
matter of a few instructions as long as the remote's ASID counter doesn't
overflow that is 255 out of 256 times.

The price to pay is to accept that both the vtag'ed I-cache and the TLB
of the remote need to be reloaded which seems relativly harmless compared
to the alternatives.

> +/**
> + * Flush the icache for a trampoline. These are used for interrupt
> + * and exception hooking.
> + *
> + * @param addr   Address to flush
> + */
> +static void octeon_flush_cache_sigtramp(unsigned long addr)
> +{
> +	/* Only flush trampolines on the current core */
> +	mb();
> +	asm volatile ("synci 0(%0)\n" : : "r" (addr));
> +}

Bug - unless Cavium SYNCI syncs all cores?  The probability is not so high
for typical apps but it's entirely possibly that on a preemptable kernel
the thread that wrote the trampoline code gets rescheduled to another
CPU before the flush is executed.  Or after the SYNCI happened on the one
core the thread is rescheduled to another CPU which then may try to
return with an inconsistent I-cache.  Boom.

> +/**
> + * Flush a specific page of a vma
> + *
> + * @param vma    VMA to flush page for
> + * @param page   Page to flush
> + * @param pfn
> + */
> +static void octeon_flush_cache_page(struct vm_area_struct *vma,
> +				    unsigned long page, unsigned long pfn)
> +{
> +	if (vma->vm_flags & (VM_EXEC|VM_EXECUTABLE))
> +		octeon_flush_icache_all_cores(vma);

Drop all references to VM_EXECUTABLE - this flag is dead.  At this low
level all that matters is VM_EXEC really.

Ok otherwise I think though in the long run we should figure out how to
fold c-cavium.c into c-r4k.c.  Life got a lot better since we eleminated
all the various of cache code we historically used to have.

  Ralf
