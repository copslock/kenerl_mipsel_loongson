Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 13:11:39 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53900 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833436Ab3AXMLihCb8d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 13:11:38 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 7CE4725B7F2;
        Thu, 24 Jan 2013 13:11:33 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sVR+ykT70ddx; Thu, 24 Jan 2013 13:11:33 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id 47B2325B7CF;
        Thu, 24 Jan 2013 13:11:33 +0100 (CET)
Message-ID: <51012501.9020200@openwrt.org>
Date:   Thu, 24 Jan 2013 13:11:45 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 08/11] MIPS: ralink: adds early_printk support
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-9-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-9-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Antivirus: avast! (VPS 130124-0, 2013.01.24), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.01.23. 13:05 keltezéssel, John Crispin írta:
> Add the code needed to make early printk work.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/early_printk.c |   43 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 arch/mips/ralink/early_printk.c
> 
> diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
> new file mode 100644
> index 0000000..c610084
> --- /dev/null
> +++ b/arch/mips/ralink/early_printk.c
> @@ -0,0 +1,43 @@
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
> +
> +static inline void uart_w32(u32 val, unsigned reg)
> +{
> +	__raw_writel((val),
> +		(void __iomem *)(KSEG1ADDR(EARLY_UART_BASE) + 4 * (reg)));

Introducing a variable for the base address would make the code much more
readable. Additionaly, compared to the OpenWrt code this is not a macro anymore,
so the parentheses around 'val' and 'reg' are not needed.

> +}
> +
> +static inline u32 uart_r32(unsigned reg)
> +{
> +	return __raw_readl(
> +		(void __iomem *)(KSEG1ADDR(EARLY_UART_BASE) + 4 * (reg)));

Ditto.

> +}
> +
> +void prom_putchar(unsigned char ch)
> +{
> +	while (((uart_r32(UART_REG_LSR)) & UART_LSR_THRE) == 0);
> +	uart_w32(UART_REG_TX, ch);
> +	while (((uart_r32(UART_REG_LSR)) & UART_LSR_THRE) == 0);

There are some superfluous parentheses inside the conditions of the while
statements. Apart from that, the trailing semicolons will cause checkpatch errors.

-Gabor

-Gabor
