Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 08:47:08 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57306 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011254AbaJVGrH1erYa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 08:47:07 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 832B42800EA;
        Wed, 22 Oct 2014 08:46:02 +0200 (CEST)
Received: from dicker-alter.lan (p548C87DD.dip0.t-ipconnect.de [84.140.135.221])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 22 Oct 2014 08:46:02 +0200 (CEST)
Message-ID: <544752E8.6070302@openwrt.org>
Date:   Wed, 22 Oct 2014 08:47:04 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     eunb.song@samsung.com, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: add arch_trigger_all_cpu_backtrace() function
References: <1669712409.167661413959996217.JavaMail.weblogic@epmlwas02b>
In-Reply-To: <1669712409.167661413959996217.JavaMail.weblogic@epmlwas02b>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi Eubong,

one small question inline ...

On 22/10/2014 08:39, Eunbong Song wrote:
> 
> Currently, arch_trigger_all_cpu_backtrace() is defined in only x86
> and sparc which has nmi interrupt. But in case of softlockup not a
> hardlockup, it could be possible to dump backtrace of all cpus. and
> this could be helpful for debugging.
> 
> for example, if system has 2 cpus.
> 
> CPU 0				CPU 1 acquire read_lock()
> 
> try to do write_lock()
> 
> ,,, missing read_unlock()
> 
> In this case, softlockup will occur becasuse CPU 0 does not call
> read_unlock(). And dump_stack() print only backtrace for "CPU 0".
> If CPU1's backtrace is printed it's very helpful.
> 
> This patch adds arch_trigger_all_cpu_backtrace() for mips
> architecture.
> 
> Maybe someone make better patch than this. I just suggest the
> idea. --- arch/mips/include/asm/irq.h |    3 +++ 
> arch/mips/kernel/process.c  |   18 ++++++++++++++++++ 2 files
> changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/include/asm/irq.h
> b/arch/mips/include/asm/irq.h index 39f07ae..5a4e1bb 100644 ---
> a/arch/mips/include/asm/irq.h +++ b/arch/mips/include/asm/irq.h @@
> -48,4 +48,7 @@ extern int cp0_compare_irq; extern int
> cp0_compare_irq_shift; extern int cp0_perfcount_irq;
> 
> +void arch_trigger_all_cpu_backtrace(bool); +#define
> arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace

What is the purpose of this define ? is this maybe a leftover from
some regex/cleanups ?

	John


> + #endif /* _ASM_IRQ_H */ diff --git a/arch/mips/kernel/process.c
> b/arch/mips/kernel/process.c index 636b074..9f51d3d 100644 ---
> a/arch/mips/kernel/process.c +++ b/arch/mips/kernel/process.c @@
> -42,6 +42,7 @@ #include <asm/isadep.h> #include <asm/inst.h> 
> #include <asm/stacktrace.h> +#include <asm/irq_regs.h>
> 
> #ifdef CONFIG_HOTPLUG_CPU void arch_cpu_idle_dead(void) @@ -532,3
> +533,20 @@ unsigned long arch_align_stack(unsigned long sp)
> 
> return sp & ALMASK; } + +static void arch_dump_stack(void *info) 
> +{ +	struct pt_regs *regs; + +	regs = get_irq_regs(); + +	if(regs) 
> +		show_regs(regs); + +	dump_stack(); +} + +void
> arch_trigger_all_cpu_backtrace(bool include_self) +{ +
> smp_call_function(arch_dump_stack, NULL, 1); +}
> 
