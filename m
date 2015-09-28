Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2015 12:55:45 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:60521 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007052AbbI1KzktrWUl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Sep 2015 12:55:40 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17C9B28;
        Mon, 28 Sep 2015 03:55:35 -0700 (PDT)
Received: from [10.1.209.148] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA6B23F2E5;
        Mon, 28 Sep 2015 03:55:30 -0700 (PDT)
Message-ID: <56091CA1.1030808@arm.com>
Date:   Mon, 28 Sep 2015 11:55:29 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     alex@alex-smith.me.uk, Alex Smith <alex.smith@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] irqchip: irq-mips-gic: Provide function to map GIC
 user section
References: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com> <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 28/09/15 11:11, Markos Chandras wrote:
> From: Alex Smith <alex.smith@imgtec.com>
> 
> The GIC provides a "user-mode visible" section containing a mirror of
> the counter registers which can be mapped into user memory. This will
> be used by the VDSO time function implementations, so provide a
> function to map it in.
> 
> When the GIC is not enabled in Kconfig a dummy inline version of this
> function is provided, along with "#define gic_present 0", so that we
> don't have to litter the VDSO code with ifdefs.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  drivers/irqchip/irq-mips-gic.c   | 27 +++++++++++++++++++++------
>  include/linux/irqchip/mips-gic.h | 24 ++++++++++++++++++++++--
>  2 files changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index af2f16bb8a94..c995b199ca32 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -13,6 +13,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/mips-gic.h>
> +#include <linux/mm.h>
>  #include <linux/of_address.h>
>  #include <linux/sched.h>
>  #include <linux/smp.h>
> @@ -29,6 +30,7 @@ struct gic_pcpu_mask {
>  	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
>  };
>  
> +static unsigned long gic_base_addr;
>  static void __iomem *gic_base;
>  static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
>  static DEFINE_SPINLOCK(gic_lock);
> @@ -301,6 +303,19 @@ int gic_get_c0_fdc_int(void)
>  				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_FDC));
>  }
>  
> +int gic_map_user_section(struct vm_area_struct *vma, unsigned long base,
> +			 unsigned long size)
> +{
> +	unsigned long pfn;
> +
> +	BUG_ON(!gic_present);

Why do you have a BUG() here, while you're just returning -1 in the case
where CONFIG_MIPS_GIC is not refined? This feels overly harsh to me.

> +	BUG_ON(size > USM_VISIBLE_SECTION_SIZE);

Same here.

> +
> +	pfn = (gic_base_addr + USM_VISIBLE_SECTION_OFS) >> PAGE_SHIFT;
> +	return io_remap_pfn_range(vma, base, pfn, size,
> +				  pgprot_noncached(PAGE_READONLY));

Two things:

- I suppose you are comfortable with making this region accessible to
userspace (obviously). Not knowing anything about it, is it guaranteed
not to trigger any unpleasant event even if the luser tries to play
dirty tricks on it (like doing unaligned or exclusive access)?

- Does this code have to be in the irqchip driver? It really feels out
of place, and I'd rather see a function that returns the mappable range
to the VDSO code, where the mapping would occur.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
