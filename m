Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 20:23:44 +0100 (CET)
Received: from mail-bk0-f51.google.com ([209.85.214.51]:61596 "EHLO
        mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833416Ab3AWTXUzZAGl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jan 2013 20:23:20 +0100
Received: by mail-bk0-f51.google.com with SMTP id ik5so182574bkc.10
        for <multiple recipients>; Wed, 23 Jan 2013 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KwK1dDsTRPwm/KCnDfPB4NAt8hYkX+GWdqzwh+uD3FM=;
        b=udBM7oYLArnyBOH39UcTIPsCK1KcZ7hSkSLmdMk/aGmWm62IyjD7Mzj03ATgTnBGEV
         DpJS9sMTHasf+5+POiBMnP/Ga7QD8BSf1Mis8SM6IUQDsDa+KD2AF/O1bNSkEdGTaGw9
         c7BeZtIYJIXV8VpsdA/rVwS0enLwxjVpwlbwzX9YoCvC9XKVBpe3dR29y/a7WglVC7FU
         dDG4bATgjH0EUWCYrwK0ZE3nAMGWPF5EbwFzKA7yKKs6FhTYRsYPrlIF1Gym8m6jmH+k
         FdrvkAZscdsKHj/5j3RS3QVbXBPX+Lfn3l1Fh1tQBASXQFRh5cwn8aMjHHw8Ftq8aLPR
         se+g==
X-Received: by 10.204.9.4 with SMTP id j4mr800742bkj.36.1358968989324;
        Wed, 23 Jan 2013 11:23:09 -0800 (PST)
Received: from ?IPv6:2a01:e35:2f70:4010:b1d4:3529:4271:81d8? ([2a01:e35:2f70:4010:b1d4:3529:4271:81d8])
        by mx.google.com with ESMTPS id c10sm15211315bkw.1.2013.01.23.11.23.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 11:23:08 -0800 (PST)
Message-ID: <510038A8.6020606@openwrt.org>
Date:   Wed, 23 Jan 2013 20:23:20 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 08/11] MIPS: ralink: adds early_printk support
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-9-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-9-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hey John,

Le 23/01/2013 13:05, John Crispin a écrit :
> Add the code needed to make early printk work.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/early_printk.c |   43 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>   create mode 100644 arch/mips/ralink/early_printk.c
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

Is that really required considering that you already include 
serial_reg.h and could use defines from there?

At some point I think that we might be able to come up with a some kind 
of generic 8250 earlyprintk code where people just tell what's the base 
address of their UART. Something like:

#define UART_BASE	KSEG1ADDR(MY_UART_BASE)
#include <asm/8250-earlyprintk.h>

> +
> +static inline void uart_w32(u32 val, unsigned reg)
> +{
> +	__raw_writel((val),
> +		(void __iomem *)(KSEG1ADDR(EARLY_UART_BASE) + 4 * (reg)));
> +}
> +
> +static inline u32 uart_r32(unsigned reg)
> +{
> +	return __raw_readl(
> +		(void __iomem *)(KSEG1ADDR(EARLY_UART_BASE) + 4 * (reg)));
> +}
> +
> +void prom_putchar(unsigned char ch)
> +{
> +	while (((uart_r32(UART_REG_LSR)) & UART_LSR_THRE) == 0);
> +	uart_w32(UART_REG_TX, ch);
> +	while (((uart_r32(UART_REG_LSR)) & UART_LSR_THRE) == 0);
> +}
>
