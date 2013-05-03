Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 May 2013 17:51:38 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:47608 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835030Ab3ECPvcOnFli (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 May 2013 17:51:32 +0200
Received: by mail-pd0-f173.google.com with SMTP id v10so987683pde.4
        for <multiple recipients>; Fri, 03 May 2013 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RWZidD/r+/H2fc0XMqTn4V0IEX+KqPxGsGp962YYPw4=;
        b=WLLUuNWkNXHMFsKfPnYtXxe5RxfDyW8lQHOQl23vuk3bVC7BC6Z42GSuP0RYXVHCel
         Uch2AeFJLF6cn7tUVMVB5HwcLXglUrOCg69LJfgMXTe7GW1jYcIpGmPTgQ9Var/UHKvJ
         GCyyNk9AtPMSL66Llcla05mAYoFxAGnr+z5OePkSALbHIOVZX617Uc/tf5m2GpGNw9w7
         GfpqnonnVDJjoNYylezkC1vXRisXYGeKCt1mxzhYyOCqFdEWWnVV8gnvcGRxk3x18ET9
         aFwHhRQdZp7r8r8myTw99i7/12EGwK5ZwUiNAofHCUl1b/hIJ3OQoRaWju/H8ytvf4Fw
         3Cnw==
X-Received: by 10.67.3.2 with SMTP id bs2mr15504898pad.132.1367596285192;
        Fri, 03 May 2013 08:51:25 -0700 (PDT)
Received: from [192.168.1.104] ([114.250.91.39])
        by mx.google.com with ESMTPSA id sg4sm12151783pbc.7.2013.05.03.08.51.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 08:51:24 -0700 (PDT)
Message-ID: <5183DCF8.10204@gmail.com>
Date:   Fri, 03 May 2013 23:51:20 +0800
From:   Jiang Liu <liuj97@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     eunb.song@samsung.com
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jogo@openwrt.org, david.daney@cavium.com
Subject: Re: MIPS : die at free_initmem() function 3.9+
References: <31174990.226951367567235155.JavaMail.weblogic@epml13>
In-Reply-To: <31174990.226951367567235155.JavaMail.weblogic@epml13>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liuj97@gmail.com
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

Hi Eunbong,
	Thanks for reporting!
	I think this issue may be caused by __pa_symbol() on 64bits MIPS machines
due to following definition:
#ifdef CONFIG_64BIT
#define __pa(x)                                                         \
({                                                                      \
    unsigned long __x = (unsigned long)(x);                             \
    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);                     \
})
#else
#define __pa(x)                                                         \
    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
#endif
#define __va(x)         ((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))

So on 64bits MIPS platforms, __va(__pa(x)) may not equal to x, that may cause
trouble to free_initmem_default(). Could you please help to do another test
by changing
	free_initmem_default(POISON_FREE_INITMEM);
to
	free_initmem_default(0);

This test could help to identify whether this panic is caused by
	memset((void *)pos, poison, PAGE_SIZE);
in function free_reserved_area().

Thanks!
Gerry

On 05/03/2013 03:47 PM, EUNBONG SONG wrote:
> 
> Hello. I try to boot my cavium board with david's patch. 
> It's is not applied yet in linux tree, i got the patch from mailing list.
> And the patch is as follow.
> 
> 
> This is only very lightly tested, we need more testing before
> declaring it the definitive fix.
> 
>  arch/mips/kernel/genex.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index ecb347c..57cda9a 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -132,12 +132,13 @@ LEAF(r4k_wait)
>         .set    noreorder
>         /* start of rollback region */
>         LONG_L  t0, TI_FLAGS($28)
> -       nop
>         andi    t0, _TIF_NEED_RESCHED
>         bnez    t0, 1f
>          nop
> -       nop
> -       nop
> +       /* Enable interrupts so WAIT will complete */
> +       mfc0    t0, CP0_STATUS
> +       ori     t0, ST0_IE
> +       mtc0    t0, CP0_STATUS
>         .set    mips3
>         wait
>         /* end of rollback region (the region size must be power of two) */
> 
> I think, it works well. But i encounter another problem at free_initmem(). 
> The log messages are as follow.
> 
> [  132.134719] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.9.0+ #29
> [  132.141678] Stack : 0000000000000004 000000000000003f ffffffff80fa0000 ffffffff802924a8
>           0000000000000000 ffffffff80fa0000 00000000000000ff ffffffff80293760
>           0000000000000000 0000000000000000 ffffffff81080000 ffffffff81080000
>           ffffffff80e2baf0 ffffffff80f93977 a80000004146cbb8 0000000000000020
>           0000000000000003 0000000000000020 a800000041473da8 ffffffff810f0000
>           a800000041473a10 ffffffff806ef910 a800000041473828 ffffffff80290920
>           0000000000000000 ffffffff80293b90 000000000000000a ffffffff80e2baf0
>           0000000000000000 a800000041473750 000000004146cef8 ffffffff805e7794
>           0000000000000000 0000000000000000 0000000000000000 0000000000000000
>           0000000000000000 ffffffff80272498 0000000000000000 0000000000000000
>           ...
> [  132.207201] Call Trace:
> [  132.209655] [<ffffffff80272498>] show_stack+0x68/0x80
> [  132.225943] [<ffffffff802bd4ac>] notifier_call_chain+0x5c/0xa8
> [  132.231776] [<ffffffff802bdb84>] __atomic_notifier_call_chain+0x3c/0x58
> [  132.238391] [<ffffffff802bdbe8>] notify_die+0x38/0x48
> [  132.243442] [<ffffffff802716cc>] die+0x4c/0x148
> [  132.247974] [<ffffffff8027f998>] do_page_fault+0x4b8/0x500
> [  132.253461] [<ffffffff8026c764>] resume_userspace_check+0x0/0x10
> [  132.259469] [<ffffffff80324a54>] free_reserved_area+0x8c/0x178
> [  132.265304] [<ffffffff806e0dc8>] kernel_init+0x20/0x100
> [  132.270529] [<ffffffff8026c7e0>] ret_from_kernel_thread+0x10/0x18
> 
> And i just changed free_initmem() functions as follow
> 
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 9b973e0..e246e9b 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -447,7 +447,10 @@ void free_initrd_mem(unsigned long start, unsigned long end)
>  void __init_refok free_initmem(void)
>  {
>         prom_free_prom_memory();
> -       free_initmem_default(POISON_FREE_INITMEM);
> +
> +       free_init_pages("unused kernel memory",
> +                       __pa_symbol(&__init_begin),
> +                       __pa_symbol(&__init_end));
>  }
> 
> After that it works well. but i don't know why it works well.
> 
> Thanks. 
> 
