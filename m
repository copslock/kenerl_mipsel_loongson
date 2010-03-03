Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 11:59:54 +0100 (CET)
Received: from kuber.nabble.com ([216.139.236.158]:45768 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490990Ab0CCK7v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 11:59:51 +0100
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1NmmIv-0003xf-Gn
        for linux-mips@linux-mips.org; Wed, 03 Mar 2010 02:59:49 -0800
Message-ID: <27766728.post@talk.nabble.com>
Date:   Wed, 3 Mar 2010 02:59:49 -0800 (PST)
From:   Dea_RU <dryukovz@mail.ru>
To:     linux-mips@linux-mips.org
Subject: Re: TI AR7 7200 - no boot
In-Reply-To: <201003031124.46336.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: dryukovz@mail.ru
References: <27766331.post@talk.nabble.com> <201003031124.46336.florian@openwrt.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dryukovz@mail.ru
Precedence: bulk
X-list: linux-mips



Florian Fainelli-4 wrote:
> 
> Hi,
> 
> You have one of these devices with bogus UART, (there are quite some out
> there)
> can you try with the following patch and tell me if that gives you an
> usable console:
> 
> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> index 246df7a..15cbeeb 100644
> --- a/arch/mips/ar7/platform.c
> +++ b/arch/mips/ar7/platform.c
> @@ -551,6 +551,7 @@ static int __init ar7_register_uarts(void)
>         uart_port.irq           = AR7_IRQ_UART0;
>         uart_port.mapbase       = AR7_REGS_UART0;
>         uart_port.membase       = ioremap(uart_port.mapbase, 256);
> +       uart_port.flags         = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
> 
>         res = early_serial_setup(&uart_port);
>         if (res)
> @@ -562,6 +563,7 @@ static int __init ar7_register_uarts(void)
>                 uart_port.irq           = AR7_IRQ_UART1;
>                 uart_port.mapbase       = UR8_REGS_UART1;
>                 uart_port.membase       = ioremap(uart_port.mapbase, 256);
> +               uart_port.flags         = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
> 
>                 res = early_serial_setup(&uart_port);
>                 if (res)
> 
> Thanks.
> -- 
> Regards, Florian
> 



after remark printk with message console color  line 2927 /drivers/char/vt.c

boot process stop with:
====================
....
Primary data cache 8kB, 4-way, VIPT, no aliases, linesize 16 bytes
Memory: 13172k/16384k available (1314k kernel code, 3212k reserved, 411k
data, 120k init, 0k highmem)
NR_IRQS:256
Calibrating delay loop... 
===============
next freeze on delay loop clculation !? IRQ not init correctly ??? 

maby after send byte over USART cpu set flag "USART TX buffer cleared"? and
kernel go to interput vector ???

=========

in kernel src 2.6.33 from mips.org patch based code not present !
/arch/mips/ar7/platform.c 

i added port number flags for version 2.6.33 ....

uart_port[0].flags         = UPF_IOREMAP | UPF_BOOT_AUTOCONF; 
uart_port[1].flags         = UPF_IOREMAP | UPF_BOOT_AUTOCONF; 

==============

after added flags and remark console collor booting stop with:

......
Primary data cache 8kB, 4-way, VIPT, no aliases, linesize 16 bytes
Memory: 13172k/16384k available (1314k kernel code, 3212k reserved, 411k
data, 120k init, 0k highmem)
NR_IRQS:256
Calibrating delay loop... 


-- 
View this message in context: http://old.nabble.com/TI-AR7-7200---no-boot-tp27766331p27766728.html
Sent from the linux-mips main mailing list archive at Nabble.com.
