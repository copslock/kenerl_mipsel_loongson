Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 10:59:01 +0100 (CET)
Received: from [209.85.219.212] ([209.85.219.212]:57977 "EHLO
        mail-ew0-f212.google.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491107Ab0BHJ64 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2010 10:58:56 +0100
Received: by ewy4 with SMTP id 4so835782ewy.27
        for <multiple recipients>; Mon, 08 Feb 2010 01:58:34 -0800 (PST)
Received: by 10.213.100.229 with SMTP id z37mr3617046ebn.28.1265623114462;
        Mon, 08 Feb 2010 01:58:34 -0800 (PST)
Received: from ?192.168.2.2? (ppp91-77-214-141.pppoe.mtu-net.ru [91.77.214.141])
        by mx.google.com with ESMTPS id 13sm2937095ewy.13.2010.02.08.01.58.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 01:58:33 -0800 (PST)
Message-ID: <4B6FE030.1080708@ru.mvista.com>
Date:   Mon, 08 Feb 2010 12:58:08 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Yoichi Yuasa <yuasa@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: add 8250/16550 serial early printk driver
References: <20100205232857.eb65967f.yuasa@linux-mips.org>
In-Reply-To: <20100205232857.eb65967f.yuasa@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Yoichi Yuasa wrote:

> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
>   
[...]
> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index 32a010d..f5d739c 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -20,6 +20,14 @@ config EARLY_PRINTK
>  	  doesn't cooperate with an X server. You should normally say N here,
>  	  unless you want to debug such a crash.
>  
> +config EARLY_PRINTK_8250
> +	bool "8250/16550 and compatible serial early printk driver"
> +	depends on EARLY_PRINTK
> +	default n
> +	help
> +	  If you say Y here, it will be possible to use a 8250/16550 serial
> +	  port as the boot console.
> +	
>   

   Tab not needed here.

> diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
> index 50511aa..7395b7f 100644
> --- a/arch/mips/include/asm/setup.h
> +++ b/arch/mips/include/asm/setup.h
> @@ -5,6 +5,15 @@
>  
>  #ifdef  __KERNEL__
>  extern void setup_early_printk(void);
> +
> +#ifdef CONFIG_EARLY_PRINTK_8250
> +extern void setup_8250_early_printk_port(unsigned long base,
> +				unsigned int reg_shift, unsigned int timeout);
> +#else
> +static inline void setup_8250_early_printk_port(unsigned long base,
> +				unsigned int reg_shift, unsigned int timeout) {}
> +#endif
> +
>  #endif /* __KERNEL__ */
>  
>  #endif /* __SETUP_H */
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 9326af5..03fc037 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
>  
>  obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
> +obj-$(CONFIG_EARLY_PRINTK_8250)	+= early_printk_8250.o
>  
>  CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
>  
> diff --git a/arch/mips/kernel/early_printk_8250.c b/arch/mips/kernel/early_printk_8250.c
> new file mode 100644
> index 0000000..6faf8fd
> --- /dev/null
> +++ b/arch/mips/kernel/early_printk_8250.c
> @@ -0,0 +1,68 @@
> +/*
> + *  8250/16550-type serial ports prom_putchar()
> + *
> + *  Copyright (C) 2010  Yoichi Yuasa <yuasa@linux-mips.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +#include <linux/io.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +
> +static unsigned long serial8250_base;
> +static unsigned int serial8250_reg_shift;
> +static unsigned int serial8250_tx_timeout;
> +
> +void setup_8250_early_printk_port(unsigned long base, unsigned int reg_shift,
> +				  unsigned int timeout)
> +{
> +	serial8250_base = base;
>   

   Why not declare 'serial8250_base' as 'void __iomem *' and only cast 
once, here?

WBR, Sergei
