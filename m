Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2010 08:23:08 +0100 (CET)
Received: from canuck.infradead.org ([134.117.69.58]:46678 "EHLO
        canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490963Ab0KYHXC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Nov 2010 08:23:02 +0100
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=laptop)
        by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1PLWAT-0000dU-UR; Thu, 25 Nov 2010 07:22:58 +0000
Received: by laptop (Postfix, from userid 1000)
        id 1157810327602; Thu, 25 Nov 2010 07:58:09 +0100 (CET)
Subject: Re: [PATCH 1/5] MIPS/Perf-events: Work with irq_work
From:   Peter Zijlstra <a.p.zijlstra@chello.nl>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     ralf@linux-mips.org, fweisbec@gmail.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
In-Reply-To: <1290063401-25440-2-git-send-email-dengcheng.zhu@gmail.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
         <1290063401-25440-2-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Thu, 25 Nov 2010 07:58:08 +0100
Message-ID: <1290668288.2072.547.camel@laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <a.p.zijlstra@chello.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.p.zijlstra@chello.nl
Precedence: bulk
X-list: linux-mips

On Thu, 2010-11-18 at 14:56 +0800, Deng-Cheng Zhu wrote:
> This is the MIPS part of the following commit by Peter Zijlstra:
> 
> e360adbe29241a0194e10e20595360dd7b98a2b3
> 	irq_work: Add generic hardirq context callbacks

Looks ok,

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---
>  arch/mips/Kconfig                    |    1 +
>  arch/mips/include/asm/perf_event.h   |   12 +-----------
>  arch/mips/kernel/perf_event_mipsxx.c |    2 +-
>  3 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 67a2fa2..c44c38d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -4,6 +4,7 @@ config MIPS
>  	select HAVE_GENERIC_DMA_COHERENT
>  	select HAVE_IDE
>  	select HAVE_OPROFILE
> +	select HAVE_IRQ_WORK
>  	select HAVE_PERF_EVENTS
>  	select PERF_USE_VMALLOC
>  	select HAVE_ARCH_KGDB
> diff --git a/arch/mips/include/asm/perf_event.h b/arch/mips/include/asm/perf_event.h
> index e00007c..d0c7749 100644
> --- a/arch/mips/include/asm/perf_event.h
> +++ b/arch/mips/include/asm/perf_event.h
> @@ -11,15 +11,5 @@
>  
>  #ifndef __MIPS_PERF_EVENT_H__
>  #define __MIPS_PERF_EVENT_H__
> -
> -/*
> - * MIPS performance counters do not raise NMI upon overflow, a regular
> - * interrupt will be signaled. Hence we can do the pending perf event
> - * work at the tail of the irq handler.
> - */
> -static inline void
> -set_perf_event_pending(void)
> -{
> -}
> -
> +/* Leave it empty here. The file is required by linux/perf_event.h */
>  #endif /* __MIPS_PERF_EVENT_H__ */
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
> index 5c7c6fc..fa00edc 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -696,7 +696,7 @@ static int mipsxx_pmu_handle_shared_irq(void)
>  	 * interrupt, not NMI.
>  	 */
>  	if (handled == IRQ_HANDLED)
> -		perf_event_do_pending();
> +		irq_work_run();
>  
>  #ifdef CONFIG_MIPS_MT_SMP
>  	read_unlock(&pmuint_rwlock);
