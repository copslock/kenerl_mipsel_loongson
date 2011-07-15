Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2011 14:30:47 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1049 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491791Ab1GOMak (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jul 2011 14:30:40 +0200
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Fri, 15 Jul 2011 05:35:31 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 15 Jul 2011 05:30:04 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 2C63A74D03; Fri, 15 Jul 2011 05:30:18 -0700 (PDT)
Received: from [10.176.68.26] (unknown [10.176.68.26]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 9A23520501; Fri, 15
 Jul 2011 05:30:16 -0700 (PDT)
Message-ID: <4E2032D7.9000704@broadcom.com>
Date:   Fri, 15 Jul 2011 14:30:15 +0200
From:   "Roland Vossen" <rvossen@broadcom.com>
Organization: Broadcom
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     "Rafael J. Wysocki" <rjw@sisk.pl>
cc:     "Jonas Gorski" <jonas.gorski@gmail.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Status of MIPS on 3.0.0-rc6 kernel
References: <4E1ECE3B.10308@broadcom.com>
 <CAOiHx=kznEFL1BELeg2psg9yw+=-A5reunG0VYTu89DGKwrSzA@mail.gmail.com>
 <201107142151.24763.rjw@sisk.pl>
In-Reply-To: <201107142151.24763.rjw@sisk.pl>
X-WSS-ID: 623EEB993B421038137-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rvossen@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10931

> Please check if the appended patch helps.

It does, I am able to build a big endian MIPS kernel now. Can you notify 
me if you submit this patch ?

Thanks, Roland.

>
> Thanks,
> Rafael
>
> ---
> From: Rafael J. Wysocki<rjw@sisk.pl>
> Subject: MIPS: Convert i8259.c to using syscore_ops
>
> The code in arch/mips/kernel/i8259.c still hasn't been converted to
> using struct syscore_ops instead of a sysdev for resume and shutdown.
> As a result, this code doesn't build any more after suspend, resume
> and shutdown callbacks have been removed from struct sysdev_class.
> Fix this problem by converting i8259.c to using syscore_ops.
>
> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> ---
>   arch/mips/kernel/i8259.c |   22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)
>
> Index: linux-2.6/arch/mips/kernel/i8259.c
> ===================================================================
> --- linux-2.6.orig/arch/mips/kernel/i8259.c
> +++ linux-2.6/arch/mips/kernel/i8259.c
> @@ -14,7 +14,7 @@
>   #include<linux/interrupt.h>
>   #include<linux/kernel.h>
>   #include<linux/spinlock.h>
> -#include<linux/sysdev.h>
> +#include<linux/syscore_ops.h>
>   #include<linux/irq.h>
>
>   #include<asm/i8259.h>
> @@ -215,14 +215,13 @@ spurious_8259A_irq:
>   	}
>   }
>
> -static int i8259A_resume(struct sys_device *dev)
> +static void i8259A_resume(void)
>   {
>   	if (i8259A_auto_eoi>= 0)
>   		init_8259A(i8259A_auto_eoi);
> -	return 0;
>   }
>
> -static int i8259A_shutdown(struct sys_device *dev)
> +static void i8259A_shutdown(void)
>   {
>   	/* Put the i8259A into a quiescent state that
>   	 * the kernel initialization code can get it
> @@ -232,26 +231,17 @@ static int i8259A_shutdown(struct sys_de
>   		outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
>   		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
>   	}
> -	return 0;
>   }
>
> -static struct sysdev_class i8259_sysdev_class = {
> -	.name = "i8259",
> +static struct syscore_ops i8259_syscore_ops = {
>   	.resume = i8259A_resume,
>   	.shutdown = i8259A_shutdown,
>   };
>
> -static struct sys_device device_i8259A = {
> -	.id	= 0,
> -	.cls	=&i8259_sysdev_class,
> -};
> -
>   static int __init i8259A_init_sysfs(void)
>   {
> -	int error = sysdev_class_register(&i8259_sysdev_class);
> -	if (!error)
> -		error = sysdev_register(&device_i8259A);
> -	return error;
> +	register_syscore_ops(&i8259_syscore_ops);
> +	return 0;
>   }
>
>   device_initcall(i8259A_init_sysfs);
>
