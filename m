Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2014 22:00:42 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:38120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007254AbaJDUAkNx0pG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Oct 2014 22:00:40 +0200
Received: from 178-85-85-44.dynamic.upc.nl ([178.85.85.44] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1XaVV5-0008CR-0Z; Sat, 04 Oct 2014 20:00:19 +0000
Received: by worktop (Postfix, from userid 1000)
        id A3A8B6E0B71; Sat,  4 Oct 2014 22:00:16 +0200 (CEST)
Date:   Sat, 4 Oct 2014 22:00:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org, Zubair.Kakakhel@imgtec.com,
        david.daney@cavium.com, paul.gortmaker@windriver.com,
        davidlohr@hp.com, macro@linux-mips.org, chenhc@lemote.com,
        zajec5@gmail.com, james.hogan@imgtec.com, keescook@chromium.org,
        alex@alex-smith.me.uk, tglx@linutronix.de, blogic@openwrt.org,
        jchandra@broadcom.com, paul.burton@imgtec.com,
        qais.yousef@imgtec.com, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, markos.chandras@imgtec.com,
        manuel.lauss@gmail.com, akpm@linux-foundation.org,
        lars.persson@axis.com
Subject: Re: [PATCH 2/3] MIPS: Setup an instruction emulation in VDSO
 protected page instead of user stack
Message-ID: <20141004200016.GB7509@worktop.ger.corp.intel.com>
References: <20141004030438.28569.85536.stgit@linux-yegoshin>
 <20141004031730.28569.38511.stgit@linux-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141004031730.28569.38511.stgit@linux-yegoshin>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Fri, Oct 03, 2014 at 08:17:30PM -0700, Leonid Yegoshin wrote:

> --- a/arch/mips/include/asm/switch_to.h
> +++ b/arch/mips/include/asm/switch_to.h
> @@ -17,6 +17,7 @@
>  #include <asm/dsp.h>
>  #include <asm/cop2.h>
>  #include <asm/msa.h>
> +#include <asm/mmu_context.h>
>  
>  struct task_struct;
>  
> @@ -104,6 +105,16 @@ do {									\
>  	disable_msa();							\
>  } while (0)
>  
> +static inline void flush_vdso_page(void)
> +{
> +	if (current->mm && cpu_context(raw_smp_processor_id(), current->mm) &&
> +	    (current->mm->context.vdso_asid[raw_smp_processor_id()] ==
> +	     cpu_asid(raw_smp_processor_id(), current->mm))) {
> +		local_flush_tlb_page(current->mm->mmap, (unsigned long)current->mm->context.vdso);
> +		current->mm->context.vdso_asid[raw_smp_processor_id()] = 0;
> +	}
> +}

Why raw_smp_processor_id() and why evaluate it 3 times, sure compilers
can be expected to do some CSE but something like:

	int cpu = smp_processor_id();

	if ( ... [cpu] ...)

is far more readable as well.

> +
>  #define finish_arch_switch(prev)					\
>  do {									\
>  	u32 __c0_stat;							\
> @@ -118,6 +129,7 @@ do {									\
>  		__restore_dsp(current);					\
>  	if (cpu_has_userlocal)						\
>  		write_c0_userlocal(current_thread_info()->tp_value);	\
> +	flush_vdso_page();                                              \
>  	__restore_watch();						\
>  } while (0)

So what I didn't see is any talk about the cost of this. Surely a TLB
flush isn't exactly free.
