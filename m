Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2018 23:08:06 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40790 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992479AbeKNWHuW3V6I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2018 23:07:50 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1031E1596;
        Wed, 14 Nov 2018 14:07:48 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 488A63F5A0;
        Wed, 14 Nov 2018 14:07:47 -0800 (PST)
Date:   Wed, 14 Nov 2018 22:07:45 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Rich Felker <dalias@libc.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181114220744.GB4044@brain-police>
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112182659.245726-3-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

On Mon, Nov 12, 2018 at 10:26:56AM -0800, Douglas Anderson wrote:
> When I had lockdep turned on and dropped into kgdb I got a nice splat
> on my system.  Specifically it hit:
>   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
> 
> Specifically it looked like this:
>   sysrq: SysRq : DEBUG
>   ------------[ cut here ]------------
>   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
>   WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
>   pstate: 604003c9 (nZCv DAIF +PAN -UAO)
>   pc : lockdep_hardirqs_on+0xf0/0x160
>   ...
>   Call trace:
>    lockdep_hardirqs_on+0xf0/0x160
>    trace_hardirqs_on+0x188/0x1ac
>    kgdb_roundup_cpus+0x14/0x3c
>    kgdb_cpu_enter+0x53c/0x5cc
>    kgdb_handle_exception+0x180/0x1d4
>    kgdb_compiled_brk_fn+0x30/0x3c
>    brk_handler+0x134/0x178
>    do_debug_exception+0xfc/0x178
>    el1_dbg+0x18/0x78
>    kgdb_breakpoint+0x34/0x58
>    sysrq_handle_dbg+0x54/0x5c
>    __handle_sysrq+0x114/0x21c
>    handle_sysrq+0x30/0x3c
>    qcom_geni_serial_isr+0x2dc/0x30c
>   ...
>   ...
>   irq event stamp: ...45
>   hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
>   hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
>   softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
>   softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
>   ---[ end trace adf21f830c46e638 ]---
> 
> Looking closely at it, it seems like a really bad idea to be calling
> local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> like it could violate spinlock semantics and cause a deadlock.
> 
> Instead, let's use a private csd alongside
> smp_call_function_single_async() to round up the other CPUs.  Using
> smp_call_function_single_async() doesn't require interrupts to be
> enabled so we can remove the offending bit of code.
> 
> In order to avoid duplicating this across all the architectures that
> use the default kgdb_roundup_cpus(), we'll add a "weak" implementation
> to debug_core.c.
> 
> Looking at all the people who previously had copies of this code,
> there were a few variants.  I've attempted to keep the variants
> working like they used to.  Specifically:
> * For arch/arc we passed NULL to kgdb_nmicallback() instead of
>   get_irq_regs().
> * For arch/mips there was a bit of extra code around
>   kgdb_nmicallback()
> 
> NOTE: In this patch we will still get into trouble if we try to round
> up a CPU that failed to round up before.  We'll try to round it up
> again and potentially hang when we try to grab the csd lock.  That's
> not new behavior but we'll still try to do better in a future patch.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v4: None
> Changes in v3:
> - No separate init call.
> - Don't round up the CPU that is doing the rounding up.
> - Add "#ifdef CONFIG_SMP" to match the rest of the file.
> - Updated desc saying we don't solve the "failed to roundup" case.
> - Document the ignored parameter.
> 
> Changes in v2:
> - Removing irq flags separated from fixing lockdep splat.
> - Don't use smp_call_function (Daniel).
> 
>  arch/arc/kernel/kgdb.c     | 10 ++--------
>  arch/arm/kernel/kgdb.c     | 12 ------------
>  arch/arm64/kernel/kgdb.c   | 12 ------------
>  arch/hexagon/kernel/kgdb.c | 27 ---------------------------
>  arch/mips/kernel/kgdb.c    |  9 +--------
>  arch/powerpc/kernel/kgdb.c |  4 ++--
>  arch/sh/kernel/kgdb.c      | 12 ------------
>  include/linux/kgdb.h       | 15 +++++++++++++--
>  kernel/debug/debug_core.c  | 35 +++++++++++++++++++++++++++++++++++
>  9 files changed, 53 insertions(+), 83 deletions(-)

[...]

> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index f3cadda45f07..23f2b5613afa 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -55,6 +55,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -220,6 +221,40 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SMP
> +
> +/*
> + * Default (weak) implementation for kgdb_roundup_cpus
> + */
> +
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> +
> +void __weak kgdb_call_nmi_hook(void *ignored)
> +{
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}

I suppose you could pass the cpu as an argument, but it doesn't really
matter. Also, I think there are cases where the CSD callback can run without
having received an IPI, so we could potentially up passing NULL for the regs
here which probably goes boom.

> +
> +void __weak kgdb_roundup_cpus(void)
> +{
> +	call_single_data_t *csd;
> +	int this_cpu = get_cpu();

Do you actually need to disable preemption here? afaict, irqs are already
disabled by the kgdb core.

> +	int cpu;
> +
> +	for_each_cpu(cpu, cpu_online_mask) {

for_each_online_cpu(cpu) ?
I'm assuming this is serialised wrt CPU hotplug somehow?

Will
