Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Aug 2010 22:28:49 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17981 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491015Ab0HYU2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Aug 2010 22:28:45 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c757d190000>; Wed, 25 Aug 2010 13:29:13 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 25 Aug 2010 13:28:41 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 25 Aug 2010 13:28:41 -0700
Message-ID: <4C757CF4.6010304@caviumnetworks.com>
Date:   Wed, 25 Aug 2010 13:28:36 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     jiang.adam@gmail.com
CC:     ralf@linux-mips.org, dmitri.vorobiev@movial.com,
        wuzhangjin@gmail.com, peterz@infradead.org, fweisbec@gmail.com,
        tj@kernel.org, tglx@linutronix.de, mingo@elte.hu,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: irq: add statckoverflow detection
References: <1282372293-30211-1-git-send-email-jiang.adam@gmail.com>
In-Reply-To: <1282372293-30211-1-git-send-email-jiang.adam@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Aug 2010 20:28:41.0754 (UTC) FILETIME=[1B81EFA0:01CB4494]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

It looks like this patch only checks when processing an interrupt, which 
doesn't seem like it would give much coverage.

Am I missing something?

David Daney


On 08/20/2010 11:31 PM, jiang.adam@gmail.com wrote:
> From: Adam Jiang<jiang.adam@gmail.com>
>
> Add stackoverflow detection to mips arch
>
> Signed-off-by: Adam Jiang<jiang.adam@gmail.com>
> ---
>   arch/mips/Kconfig.debug |    7 +++++++
>   arch/mips/kernel/irq.c  |   19 +++++++++++++++++++
>   2 files changed, 26 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index 43dc279..f1a00a2 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -67,6 +67,13 @@ config CMDLINE_OVERRIDE
>
>   	  Normally, you will choose 'N' here.
>
> +config DEBUG_STACKOVERFLOW
> +	bool "Check for stack overflows"
> +	depends on DEBUG_KERNEL
> +	help
> +	  This option will cause messages to be printed if free stack space
> +	  drops below a certain limit.
> +
>   config DEBUG_STACK_USAGE
>   	bool "Enable stack utilization instrumentation"
>   	depends on DEBUG_KERNEL
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index c6345f5..6334037 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -151,6 +151,22 @@ void __init init_IRQ(void)
>   #endif
>   }
>
> +static inline void check_stack_overflow(void)
> +{
> +#ifdef CONFIG_DEBUG_STACKOVERFLOW
> +	long sp;
> +
> +	asm volatile("move %0, $sp" : "=r" (sp));
> +	sp = sp&  (THREAD_SIZE-1);
> +
> +	/* check for stack overflow: is there less then 2KB free? */
> +	if (unlikely(sp<  (sizeof(struct thread_info) + 2048))) {
> +		printk("do_IRQ: stack overflow: %ld\n",
> +		       sp - sizeof(struct thread_info));
> +		dump_stack();
> +	}
> +#endif
> +}
>   /*
>    * do_IRQ handles all normal device IRQ's (the special
>    * SMP cross-CPU interrupts have their own specific
> @@ -159,6 +175,9 @@ void __init init_IRQ(void)
>   void __irq_entry do_IRQ(unsigned int irq)
>   {
>   	irq_enter();
> +
> +	check_stack_overflow();
> +
>   	__DO_IRQ_SMTC_HOOK(irq);
>   	generic_handle_irq(irq);
>   	irq_exit();
