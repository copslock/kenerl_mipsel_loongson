Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Aug 2010 15:10:08 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:42746 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490945Ab0HUNKB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Aug 2010 15:10:01 +0200
Received: by eye22 with SMTP id 22so3042033eye.36
        for <multiple recipients>; Sat, 21 Aug 2010 06:10:00 -0700 (PDT)
Received: by 10.213.105.77 with SMTP id s13mr2644792ebo.50.1282396199918;
        Sat, 21 Aug 2010 06:09:59 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.54.27])
        by mx.google.com with ESMTPS id a48sm6854178eei.13.2010.08.21.06.09.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 06:09:57 -0700 (PDT)
Message-ID: <4C6FCFC7.7020903@mvista.com>
Date:   Sat, 21 Aug 2010 17:08:23 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     jiang.adam@gmail.com
CC:     ralf@linux-mips.org, dmitri.vorobiev@movial.com,
        wuzhangjin@gmail.com, ddaney@caviumnetworks.com,
        peterz@infradead.org, fweisbec@gmail.com, tj@kernel.org,
        tglx@linutronix.de, mingo@elte.hu, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: irq: add statckoverflow detection
References: <1282372293-30211-1-git-send-email-jiang.adam@gmail.com>
In-Reply-To: <1282372293-30211-1-git-send-email-jiang.adam@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

jiang.adam@gmail.com wrote:

> From: Adam Jiang <jiang.adam@gmail.com>

> Add stackoverflow detection to mips arch

> Signed-off-by: Adam Jiang <jiang.adam@gmail.com>
[...]
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index c6345f5..6334037 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -151,6 +151,22 @@ void __init init_IRQ(void)
>  #endif
>  }
>  
> +static inline void check_stack_overflow(void)
> +{
> +#ifdef CONFIG_DEBUG_STACKOVERFLOW

    #ifdef within function is considered bad style. Better do it this way:

#ifdef CONFIG_DEBUG_STACKOVERFLOW
static inline void check_stack_overflow(void)
{
[...]
}
#else
static inline void check_stack_overflow(void) {}
#endif

> +	long sp;
> +
> +	asm volatile("move %0, $sp" : "=r" (sp));
> +	sp = sp & (THREAD_SIZE-1);
> +
> +	/* check for stack overflow: is there less then 2KB free? */

    Hm, 2KB seems pretty large margin...

WBR, Sergei
