Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2011 21:54:54 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:47527 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904164Ab1KEUyq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Nov 2011 21:54:46 +0100
Received: by wyf28 with SMTP id 28so4382786wyf.36
        for <multiple recipients>; Sat, 05 Nov 2011 13:54:40 -0700 (PDT)
Received: by 10.227.205.130 with SMTP id fq2mr25537715wbb.17.1320526480163;
        Sat, 05 Nov 2011 13:54:40 -0700 (PDT)
Received: from [192.168.122.59] (smart152.bb.netvision.net.il. [212.143.76.5])
        by mx.google.com with ESMTPS id l20sm21415013wbo.6.2011.11.05.13.54.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 13:54:39 -0700 (PDT)
Message-ID: <4EB5A28F.9060005@mvista.com>
Date:   Sat, 05 Nov 2011 22:54:39 +0200
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     Maxime Bizon <mbizon@freebox.fr>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 04/11] MIPS: BCM63XX: introduce bcm_readll & bcm_writell.
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr> <1320430175-13725-5-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1320430175-13725-5-git-send-email-mbizon@freebox.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4382

Hello.

On 04.11.2011 20:09, Maxime Bizon wrote:

> Needed for upcoming 6368 CPU support.
>
> Signed-off-by: Maxime Bizon<mbizon@freebox.fr>
> ---
>   arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
> index 91180fa..8bf4a67 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
> @@ -49,9 +49,11 @@
>   #define bcm_readb(a)	(*(volatile unsigned char *)	BCM_REGS_VA(a))
>   #define bcm_readw(a)	(*(volatile unsigned short *)	BCM_REGS_VA(a))
>   #define bcm_readl(a)	(*(volatile unsigned int *)	BCM_REGS_VA(a))
> +#define bcm_readll(a)	(*(volatile u64 *)		BCM_REGS_VA(a))
>   #define bcm_writeb(v, a) (*(volatile unsigned char *) BCM_REGS_VA((a)) = (v))
>   #define bcm_writew(v, a) (*(volatile unsigned short *) BCM_REGS_VA((a)) = (v))
>   #define bcm_writel(v, a) (*(volatile unsigned int *) BCM_REGS_VA((a)) = (v))
> +#define bcm_writell(v, a) (*(volatile u64 *) BCM_REGS_VA((a)) = (v))

    64-bit accessors are generally called readq()/writeq().

WBR, Sergei
