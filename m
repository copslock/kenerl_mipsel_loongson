Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Aug 2010 10:29:13 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:33937 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491180Ab0HZI3J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Aug 2010 10:29:09 +0200
Received: by ewy9 with SMTP id 9so1222129ewy.36
        for <multiple recipients>; Thu, 26 Aug 2010 01:29:08 -0700 (PDT)
Received: by 10.213.105.79 with SMTP id s15mr402439ebo.48.1282811347904;
        Thu, 26 Aug 2010 01:29:07 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.54.121])
        by mx.google.com with ESMTPS id v8sm3651031eeh.2.2010.08.26.01.29.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 01:29:06 -0700 (PDT)
Message-ID: <4C762572.4070509@mvista.com>
Date:   Thu, 26 Aug 2010 12:27:30 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Adam Jiang <jiang.adam@gmail.com>
CC:     ralf@linux-mips.org, dmitri.vorobiev@movial.com,
        wuzhangjin@gmail.com, ddaney@caviumnetworks.com,
        peterz@infradead.org, fweisbec@gmail.com, tj@kernel.org,
        tglx@linutronix.de, mingo@elte.hu, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mips: irq: add stackoverflow detection
References: <linux-kernel@vger.kernel.org> <1282794933-20639-1-git-send-email-jiang.adam@gmail.com>
In-Reply-To: <1282794933-20639-1-git-send-email-jiang.adam@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Adam Jiang wrote:

> Add stackoverflow detection to mips arch

[...]

> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index c6345f5..75c584d 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -151,6 +151,25 @@ void __init init_IRQ(void)
>  #endif
>  }
>  
> +#ifdef CONFIG_DEBUG_STACKOVERFLOW
> +static inline void check_stack_overflow(void)
> +{
> +	long sp;
> +
> +	asm volatile("move %0, $sp" : "=r" (sp));
> +	sp = sp & (THREAD_SIZE-1);
> +
> +	/* check for stack overflow: is there less than 2KB free? */
> +	if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
> +		printk("do_IRQ: stack overflow: %ld\n",
> +		       sp - sizeof(struct thread_info));
> +		dump_stack();
> +	}
> +}
> +#else
> +static inline void check_stack_overflow(void)

    You didn't even try to compile with the option disabled -- you've missed {}.

> +#endif
> +
>  /*
>   * do_IRQ handles all normal device IRQ's (the special
>   * SMP cross-CPU interrupts have their own specific

WBR, Sergei
