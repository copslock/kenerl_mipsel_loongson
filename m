Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jan 2013 20:26:46 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:56728 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833471Ab3A0T0pPHGHm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Jan 2013 20:26:45 +0100
Received: by mail-lb0-f177.google.com with SMTP id go11so2963605lbb.8
        for <linux-mips@linux-mips.org>; Sun, 27 Jan 2013 11:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=0XflQaUdkG4Sc4KEU0D1lTOe71FJd7H0Xw5lvPgoFhg=;
        b=kXDdvDLatWv3UYvwgcdb9kL+vyvev5JDOKH8eAa74u0G0ZdnBzBQMKHNwhZa/0fyIG
         iKQDLzLgKMqNQpTxRvXwHxUCZwv1rOZqo6OylH6+E2K117pw0DIAgVyMiG4XAuKdPoMo
         fsNsnceG/oIpNQdznyXhm8ymOxpygeT8VArNb2yTX16SzkAm/lesa94vkF/RfHJsCd4F
         cJELXMo9f/uAHdDQgBWdqIo3sWptZOuo2UqfL5cUQRs8vE/xIdac4mXPV56Ve8msWLAW
         2YZHGDHTsSNGH3fqg+klLjqNcaqqX9t/1lzKxXTmTL+dfrHODd1L4yKDuV2Vhg+sFSO7
         Kohg==
X-Received: by 10.152.125.239 with SMTP id mt15mr11043770lab.26.1359314798992;
        Sun, 27 Jan 2013 11:26:38 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-68-130.pppoe.mtu-net.ru. [91.79.68.130])
        by mx.google.com with ESMTPS id o2sm2689272lby.11.2013.01.27.11.26.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 11:26:38 -0800 (PST)
Message-ID: <51057F5E.80708@mvista.com>
Date:   Sun, 27 Jan 2013 23:26:22 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 07/10] MIPS: ralink: adds early_printk support
References: <1359309842-31925-1-git-send-email-blogic@openwrt.org> <1359309842-31925-8-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359309842-31925-8-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkoS4YX+MYMqVOfCjJeAwy5+sfTytvNLagvQFslR2+56AMk7mutHarRFMXWtuhmL6djXWJp
X-archive-position: 35579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 27-01-2013 22:03, John Crispin wrote:

> Add the code needed to make early printk work.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/early_printk.c |   45 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100644 arch/mips/ralink/early_printk.c

> diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
> new file mode 100644
> index 0000000..7a9b474
> --- /dev/null
> +++ b/arch/mips/ralink/early_printk.c
> @@ -0,0 +1,45 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2011-2012 Gabor Juhos <juhosg@openwrt.org>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/serial_reg.h>
> +
> +#include <asm/addrspace.h>
> +
> +/* UART registers */
> +#define EARLY_UART_BASE         0x10000c00
> +
> +#define UART_REG_RX             0
> +#define UART_REG_TX             1
> +#define UART_REG_IER            2
> +#define UART_REG_IIR            3
> +#define UART_REG_FCR            4
> +#define UART_REG_LCR            5
> +#define UART_REG_MCR            6
> +#define UART_REG_LSR            7

    Isn;t it better to have register offsets premultiplied by 4? Saves you a 
multiplication in read/write functions (although they probably would be 
optmized out by gcc anyway).

> +
> +static __iomem void *uart_membase = (__iomem void *) KSEG1ADDR(EARLY_UART_BASE);
> +
> +static inline void uart_w32(u32 val, unsigned reg)
> +{
> +	__raw_writel(val, uart_membase + (4 * reg));
> +}
> +
> +static inline u32 uart_r32(unsigned reg)
> +{
> +	return __raw_readl(uart_membase + (4 * reg));
> +}

WBR, Sergei
