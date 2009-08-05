Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2009 10:08:32 +0200 (CEST)
Received: from main.gmane.org ([80.91.229.2]:45419 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492429AbZHEII0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Aug 2009 10:08:26 +0200
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MYbXp-0004kr-Cx
	for linux-mips@linux-mips.org; Wed, 05 Aug 2009 08:08:21 +0000
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 05 Aug 2009 08:08:21 +0000
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 05 Aug 2009 08:08:21 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: [PATCH] ar7: register watchdog driver only if enabled in hardware configuration
Date:	Wed, 5 Aug 2009 09:00:35 +0100
Message-ID:  <3qqnk6-j07.ln1@chipmunk.wormnet.eu>
References:  <200908042309.36721.florian@openwrt.org>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Florian Fainelli <florian@openwrt.org> wrote:
>
> This patch checks if the watchdog enable bit is set in the DCL
> register meaning that the hardware watchdog actually works and
> if so, register the ar7_wdt platform_device.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> index e2278c0..835f3f0 100644
> --- a/arch/mips/ar7/platform.c
> +++ b/arch/mips/ar7/platform.c
> @@ -503,6 +503,7 @@ static int __init ar7_register_devices(void)
> {
>        u16 chip_id;
>        int res;
> +       u32 *bootcr, val;
> #ifdef CONFIG_SERIAL_8250
>        static struct uart_port uart_port[2];
> 
> @@ -595,7 +596,13 @@ static int __init ar7_register_devices(void)
> 
>        ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
> 
> -       res = platform_device_register(&ar7_wdt);
> +       bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
> +       val = *bootcr;
> +       iounmap(bootcr);
> +
> +       /* Register watchdog only if enabled in hardware */
> +       if (val & AR7_WDT_HW_ENA)
> +               res = platform_device_register(&ar7_wdt);
> 
>        return res;
> }
>
'res' can now return NULL[1].  Solved if you do:
----
int res = -ENODEV;
----

I'm guessing this is the most apprioate?

Cheers

[1] I cannot see the full file annoyingly, it's not in my linux-mips 
	git tree.

-- 
Alexander Clouter
.sigmonster says: It doesn't matter whether you win or lose -- until you lose.
