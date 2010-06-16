Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2010 18:01:08 +0200 (CEST)
Received: from cantor.suse.de ([195.135.220.2]:32968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491118Ab0FPQBE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jun 2010 18:01:04 +0200
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id DF9F48D893;
        Wed, 16 Jun 2010 18:00:59 +0200 (CEST)
Date:   Wed, 16 Jun 2010 18:00:59 +0200 (CEST)
From:   Jiri Kosina <jkosina@suse.cz>
To:     Christoph Egger <siccegge@cs.fau.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gilles Espinasse <g.esp@free.fr>, Tejun Heo <tj@kernel.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 3/9] Removing dead CONFIG_SIBYTE_BCM1480_PROF
In-Reply-To: <c217f4530c057f4b8030bd14459a0cb2856decde.1275925108.git.siccegge@cs.fau.de>
Message-ID: <alpine.LNX.2.00.1006161800290.12271@pobox.suse.cz>
References: <cover.1275925108.git.siccegge@cs.fau.de> <c217f4530c057f4b8030bd14459a0cb2856decde.1275925108.git.siccegge@cs.fau.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 27146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jkosina@suse.cz
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11305

On Wed, 9 Jun 2010, Christoph Egger wrote:

> CONFIG_SIBYTE_BCM1480_PROF doesn't exist in Kconfig, therefore removing all
> references for it from the source code.

The patch isn't present in linux-next as of today. I have applied it to my 
tree, thanks.

> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/mips/sibyte/bcm1480/irq.c |   11 -----------
>  1 files changed, 0 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
> index 044bbe4..919d2d5 100644
> --- a/arch/mips/sibyte/bcm1480/irq.c
> +++ b/arch/mips/sibyte/bcm1480/irq.c
> @@ -362,19 +362,8 @@ asmlinkage void plat_irq_dispatch(void)
>  	unsigned int cpu = smp_processor_id();
>  	unsigned int pending;
>  
> -#ifdef CONFIG_SIBYTE_BCM1480_PROF
> -	/* Set compare to count to silence count/compare timer interrupts */
> -	write_c0_compare(read_c0_count());
> -#endif
> -
>  	pending = read_c0_cause() & read_c0_status();
>  
> -#ifdef CONFIG_SIBYTE_BCM1480_PROF
> -	if (pending & CAUSEF_IP7)	/* Cpu performance counter interrupt */
> -		sbprof_cpu_intr();
> -	else
> -#endif
> -
>  	if (pending & CAUSEF_IP4)
>  		do_IRQ(K_BCM1480_INT_TIMER_0 + cpu);
>  #ifdef CONFIG_SMP
> -- 
> 1.6.3.3
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
