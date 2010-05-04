Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 13:26:01 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:46818 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492479Ab0EDLZ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 13:25:58 +0200
Received: by pvg4 with SMTP id 4so1513525pvg.36
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=YH7PhPhXhpX+xYg9HMn1vSZShUZ+FBZ3EFBRO56yoBo=;
        b=P1coYcJKsx6MEw8n5d6jnHgQXxoMztdh3Fs9f40NDDN7wsjZYG+7gZ97xxtW8Q9cUM
         xqOHHaWOeKPqBQQkZDCPtSw+mAlqZ/eCMPAgbXfvWULlL5nZFQBe41in58MZWO+lvsGq
         wJ0kY8k+3Y1YYARryKcIQUA0084vHp5dRhdAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=JkyfSUCe6QD9uc3vp6lPMOky8Zly4t+GNb5rPdXQTVR7CBG6qkOm6Ggr/bNMPJCzzT
         XfL1MFJ528KQdTgiSlkTpq4yRaMkFUnPyXnw0Q7C2cbhuBVUU4cVO24rOyGLsAiLaDAg
         CKzxBL0aqXfmA1iSd3WKx9ALRWPrQPUQq1LSE=
Received: by 10.114.215.30 with SMTP id n30mr820677wag.27.1272972349638;
        Tue, 04 May 2010 04:25:49 -0700 (PDT)
Received: from [192.168.2.214] ([202.201.14.140])
        by mx.google.com with ESMTPS id v13sm29159980wav.14.2010.05.04.04.25.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 04:25:49 -0700 (PDT)
Subject: Re: [PATCH 2/12] add basic gdium support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     yajin <yajinzhou@vm-kernel.org>
Cc:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        apatard@mandriva.com
In-Reply-To: <r2y180e2c241005040255l8b43dc20t6402eadc4b567987@mail.gmail.com>
References: <r2y180e2c241005040255l8b43dc20t6402eadc4b567987@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 04 May 2010 19:25:43 +0800
Message-ID: <1272972343.9547.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Yajin

On Tue, 2010-05-04 at 17:55 +0800, yajin wrote:
> Gdium is same to most of the loongson2f based machines except that it
> does NOT use the cs5536 south bridge.
> 
> Signed-off-by: yajin <yajin@vm-kernel.org>
[...]
>  #
>  # MIPS Malta board
> diff --git a/arch/mips/include/asm/mach-loongson/machine.h
> b/arch/mips/include/asm/mach-loongson/machine.h
> index 4321338..fb9554c 100644
> --- a/arch/mips/include/asm/mach-loongson/machine.h
> +++ b/arch/mips/include/asm/mach-loongson/machine.h
> @@ -24,4 +24,11 @@
> 
>  #endif
> 
> +/* use gdium as the default machine of LEMOTE_MACH2F */

Several machines shared the same LEMOTE_MACH2F config, I have added the
above comment for the default one, therefore, this is not needed for
gdium, you can remove it directly.

> +#ifdef CONFIG_DEXXON_GDIUM
> +
> +#define LOONGSON_MACHTYPE MACH_DEXXON_GDIUM2F10
> +
> +#endif
> +

Suggest you remove the 'useless' blank line between the #ifdef and
#endif and also the other blank lines in the original machine.h added by
me, just found they are really useless.

>  #endif /* __ASM_MACH_LOONGSON_MACHINE_H */
> diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> index 3df1967..90a02b4 100644
> --- a/arch/mips/loongson/Kconfig
> +++ b/arch/mips/loongson/Kconfig
> @@ -57,6 +57,31 @@ config LEMOTE_MACH2F
> 
>  	  These family machines include fuloong2f mini PC, yeeloong2f notebook,
>  	  LingLoong allinone PC and so forth.
> +
> +config DEXXON_GDIUM
> +        bool "Dexxon Gdium Netbook"
> +        select ARCH_SPARSEMEM_ENABLE
> +        select BOARD_SCACHE
> +        select BOOT_ELF32
> +        select CEVT_R4K
> +        select CPU_HAS_WB
> +        select CSRC_R4K
> +        select DMA_NONCOHERENT
> +        select GENERIC_HARDIRQS_NO__DO_IRQ
> +        select GENERIC_ISA_DMA_SUPPORT_BROKEN
> +        select HW_HAS_PCI
> +        select I8259
> +        select IRQ_CPU
> +        select ISA
> +        select SYS_HAS_CPU_LOONGSON2F
> +        select SYS_HAS_EARLY_PRINTK
> +        select SYS_SUPPORTS_32BIT_KERNEL
> +        select SYS_SUPPORTS_64BIT_KERNEL
> +        select SYS_SUPPORTS_HIGHMEM
> +        select SYS_SUPPORTS_LITTLE_ENDIAN
> +        select ARCH_REQUIRE_GPIOLIB

Perhaps you can move "select ARCH_REQUIRE_GPIOLIB" before "select
ARCH_SPARSEMEM_ENABLE" to make them in alphabetical order.

> +        help
> +          Dexxon gdium netbook based on Loongson 2F and SM502.
>  endchoice
> 
>  config CS5536
> diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson/Makefile
> index 2b76cb0..6002109 100644
> --- a/arch/mips/loongson/Makefile
> +++ b/arch/mips/loongson/Makefile
> @@ -15,3 +15,9 @@ obj-$(CONFIG_LEMOTE_FULOONG2E)  += fuloong-2e/
>  #
> 
>  obj-$(CONFIG_LEMOTE_MACH2F)  += lemote-2f/
> +
> +#
> +# gdium
> +#
> +
> +obj-$(CONFIG_DEXXON_GDIUM)  += gdium/
> diff --git a/arch/mips/loongson/gdium/Makefile
> b/arch/mips/loongson/gdium/Makefile
> new file mode 100644
> index 0000000..31a8e57
> --- /dev/null
> +++ b/arch/mips/loongson/gdium/Makefile
> @@ -0,0 +1,3 @@
> +# Makefile for gdium
> +
> +obj-y += irq.o reset.o
> diff --git a/arch/mips/loongson/gdium/irq.c b/arch/mips/loongson/gdium/irq.c
> new file mode 100644
> index 0000000..b0679eb
> --- /dev/null
> +++ b/arch/mips/loongson/gdium/irq.c
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright (C) 2007 Lemote Inc.
> + * Author: Fuxin Zhang, zhangfx@lemote.com
> + *
> + * Copyright (c) 2010 yajin <yajin@vm-kernel.org>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +
> +#include <asm/irq_cpu.h>
> +#include <asm/mipsregs.h>
> +
> +#include <loongson.h>
> +#include <machine.h>
> +
> +#define LOONGSON_TIMER_IRQ      (MIPS_CPU_IRQ_BASE + 7) /* cpu timer */
> +#define LOONGSON_PERFCNT_IRQ    (MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
> +#define LOONGSON_NORTH_BRIDGE_IRQ       (MIPS_CPU_IRQ_BASE + 6) /* bonito */
> +#define LOONGSON_UART_IRQ       (MIPS_CPU_IRQ_BASE + 3) /* cpu serial port */
> +
> +void mach_irq_dispatch(unsigned int pending)
> +{
> +	if (pending & CAUSEF_IP7)
> +		do_IRQ(LOONGSON_TIMER_IRQ);
> +	else if (pending & CAUSEF_IP6) {        /* North Bridge, Perf counter */
> +#ifdef CONFIG_OPROFILE
> +		do_IRQ(LOONGSON2_PERFCNT_IRQ);
> +#endif

Ralf just applied one patch from me for the Oprofile problem when it is
configured as module, that commit is:

"MIPS: oprofile: Fix breakage when CONFIG_OPROFILE=m"

The #ifdef condition should be changed to "#if defined(CONFIG_OPROFILE)
|| defined(CONFIG_OPROFILE_MODULE)" to ensure the do_IRQ() is called
when the Oprofile driver is configured as a module.

To reduce the duplication and make it maintainable, Perhaps we can add
an inline function to loongson.h for this specific stuff.

static inline do_perfcnt_IRQ()
{
#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
	do_IRQ(LOONGSON2_PERFCNT_IRQ);
#endif
}

Regards,
	Wu Zhangjin
