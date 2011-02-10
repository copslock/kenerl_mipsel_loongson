Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2011 19:16:29 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:33078 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491123Ab1BJSQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Feb 2011 19:16:26 +0100
Received: by bwz5 with SMTP id 5so2237619bwz.36
        for <linux-mips@linux-mips.org>; Thu, 10 Feb 2011 10:16:20 -0800 (PST)
Received: by 10.204.72.199 with SMTP id n7mr14301227bkj.8.1297361780476;
        Thu, 10 Feb 2011 10:16:20 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id v25sm205978bkt.6.2011.02.10.10.16.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 10:16:19 -0800 (PST)
Message-ID: <4D542B1D.1060407@mvista.com>
Date:   Thu, 10 Feb 2011 21:14:53 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: DB1200: Set Config_OD for improved stability.
References: <1297347429-18215-1-git-send-email-manuel.lauss@googlemail.com> <1297347429-18215-2-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1297347429-18215-2-git-send-email-manuel.lauss@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Setting Config_OD gets rid of a _LOT_ of spurious CPLD interrupts,
> but also decreases overall performance a bit.

> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
[...]

> diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
> index 8876195..a3729c9 100644
> --- a/arch/mips/alchemy/devboards/db1200/setup.c
> +++ b/arch/mips/alchemy/devboards/db1200/setup.c
> @@ -23,6 +23,13 @@ void __init board_setup(void)
>  	unsigned long freq0, clksrc, div, pfc;
>  	unsigned short whoami;
>  
> +	/* Set Config_OD (disable overlapping bus transaction):

    The bit is called Config[OD] by other Alchemy code.
    You just should add your Au1200 revision to au1xxx_cpu_needs_config_od() in 
<asm/mach-au1x00.h> so that plat_mem_setup() automatically sets the bit (just 
after it calls board_setup()); Au1200 rev. AC should have it set already...

> +	 * This gets rid of a _lot_ of spurious interrupts (especially
> +	 * wrt. IDE); but incurs ~10% performance hit in some
> +	 * cpu-bound applications.
> +	 */
> +	set_c0_config(1 << 19);
> +
>  	bcsr_init(DB1200_BCSR_PHYS_ADDR,
>  		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
>  

WBR, Sergei
