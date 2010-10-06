Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2010 12:55:32 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:38338 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab0JFKz3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Oct 2010 12:55:29 +0200
Received: by ewy9 with SMTP id 9so3308620ewy.36
        for <multiple recipients>; Wed, 06 Oct 2010 03:55:28 -0700 (PDT)
Received: by 10.213.25.141 with SMTP id z13mr9429091ebb.60.1286362528256;
        Wed, 06 Oct 2010 03:55:28 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.39.143])
        by mx.google.com with ESMTPS id a48sm1260205eei.18.2010.10.06.03.55.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 03:55:27 -0700 (PDT)
Message-ID: <4CAC5537.9040904@mvista.com>
Date:   Wed, 06 Oct 2010 14:53:43 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To:     Adam Jiang <jiang.adam@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mips: irq: add stackoverflow detection
References: <1286361676-10743-1-git-send-email-jiang.adam@gmail.com>
In-Reply-To: <1286361676-10743-1-git-send-email-jiang.adam@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 06-10-2010 14:41, Adam Jiang wrote:

> Add stackoverflow detection to mips arch

    There's no such word: stackoverflow. Space is needed.

> This is the 3rd version of the smiple patch. 2K is too big for many
> system, so I Modified the warning line by following Ralf's suggestion.

> Signed-off-by: Adam Jiang<jiang.adam@gmail.com>
[...]

> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index c6345f5..b43edb7 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -151,6 +151,28 @@ void __init init_IRQ(void)
>   #endif
>   }
>
> +#ifdef CONFIG_DEBUG_STACKOVERFLOW
> +static inline void check_stack_overflow(void)
> +{
> +	unsigned long sp;
> +
> +	asm volatile("move %0, $sp" : "=r" (sp));
> +	sp = sp & THREAD_MASK;

    Why not:

	sp &= THREAD_MASK;

    It's C, after all! :-)

WBR, Sergei
