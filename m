Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 14:49:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17166 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006954AbcDAMtBmKINB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2016 14:49:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 50962E61700A8;
        Fri,  1 Apr 2016 13:48:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 1 Apr 2016 13:48:55 +0100
Received: from localhost (10.100.200.246) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 1 Apr
 2016 13:48:54 +0100
Date:   Fri, 1 Apr 2016 13:48:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Qais Yousef <qsyousef@gmail.com>, <ralf@linux-mips.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
Message-ID: <20160401124852.GA5145@NP-P-BURTON>
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.246]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Thu, Mar 17, 2016 at 09:08:09PM +0000, Qais Yousef wrote:
> Malta defconfig compiles with GIC on. Hence when compiling for SMP it causes the
> new IPI code to be activated. But on qemu malta there's no GIC causing a
> BUG_ON(!ipidomain) to be hit in mips_smp_ipi_init().
> 
> Since in that configuration one can only run a single core SMP (!), skip IPI
> initialisation if we detect that this is the case. It is a sensible behaviour
> to introduce and should keep such possible configuration to run rather than die
> hard unnecessarily.

Hi Qais/Ralf,

This patch is insufficient I'm afraid. It's entirely possible to use SMP
with multiple VPEs in a single core on Malta boards that don't have a
GIC - we have code handling IPIs in that case guarded by #ifdef
CONFIG_MIPS_MT_SMP in arch/mips/mti-malta/malta-int.c. I think the
BUG_ON needs to be removed entirely, unless that single-core multi-VPE
IPI code is also converted to use an IPI irqdomain.

Thanks,
    Paul

> 
> Signed-off-by: Qais Yousef <qsyousef@gmail.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/mips/kernel/smp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 37708d9..27cb638 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -243,6 +243,18 @@ static int __init mips_smp_ipi_init(void)
>  	struct irq_domain *ipidomain;
>  	struct device_node *node;
>  
> +	/*
> +	 * In some cases like qemu-malta, it is desired to try SMP with
> +	 * a single core. Qemu-malta has no GIC, so an attempt to set any IPIs
> +	 * would cause a BUG_ON() to be triggered since there's no ipidomain.
> +	 *
> +	 * Since for a single core system IPIs aren't required really, skip the
> +	 * initialisation which should generally keep any such configurations
> +	 * happy and only fail hard when trying to truely run SMP.
> +	 */
> +	if (cpumask_weight(cpu_possible_mask) == 1)
> +		return 0;
> +
>  	node = of_irq_find_parent(of_root);
>  	ipidomain = irq_find_matching_host(node, DOMAIN_BUS_IPI);
>  
> -- 
> 2.7.3
> 
> 
