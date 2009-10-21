Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:46:51 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:64105 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493594AbZJUOqo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:46:44 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta01.mail.rr.com with ESMTP
          id <20091021144634721.ZXM26298@hrndva-omta01.mail.rr.com>;
          Wed, 21 Oct 2009 14:46:34 +0000
Subject: Re: [PATCH -v4 3/9] tracing: add MIPS specific trace_clock_local()
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Wed, 21 Oct 2009 10:46:33 -0400
Message-Id: <1256136393.18347.2997.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Wed, 2009-10-21 at 22:34 +0800, Wu Zhangjin wrote:
> This patch add the mips_timecounter_read() based high precision version
> of trace_clock_local().
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/kernel/Makefile      |    6 ++++++
>  arch/mips/kernel/trace_clock.c |   37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/kernel/trace_clock.c
> 
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 8e26e9c..f228868 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -8,6 +8,10 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
>  		   ptrace.o reset.o setup.o signal.o syscall.o \
>  		   time.o topology.o traps.o unaligned.o watch.o
>  
> +ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_trace_clock.o = -pg
> +endif
> +
>  obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
>  obj-$(CONFIG_CEVT_R4K_LIB)	+= cevt-r4k.o
>  obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
> @@ -24,6 +28,8 @@ obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
>  
> +obj-$(CONFIG_FTRACE)		+= trace_clock.o
> +
>  obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
> diff --git a/arch/mips/kernel/trace_clock.c b/arch/mips/kernel/trace_clock.c
> new file mode 100644
> index 0000000..2e3475f
> --- /dev/null
> +++ b/arch/mips/kernel/trace_clock.c
> @@ -0,0 +1,37 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive for
> + * more details.
> + *
> + * Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University, China
> + * Author: Wu Zhangjin <wuzj@lemote.com>
> + */
> +
> +#include <linux/clocksource.h>
> +#include <linux/sched.h>
> +
> +#include <asm/time.h>
> +
> +/*
> + * trace_clock_local(): the simplest and least coherent tracing clock.
> + *
> + * Useful for tracing that does not cross to other CPUs nor
> + * does it go through idle events.
> + */
> +u64 trace_clock_local(void)
> +{
> +	unsigned long flags;
> +	u64 clock;
> +
> +	raw_local_irq_save(flags);
> +
> +	preempt_disable_notrace();

Why have the preempt_disable? You disable interrupts already, that will
prevent any preemption at that point.

-- Steve

> +
> +	clock = mips_timecounter_read();
> +
> +	preempt_enable_no_resched_notrace();
> +
> +	raw_local_irq_restore(flags);
> +
> +	return clock;
> +}
