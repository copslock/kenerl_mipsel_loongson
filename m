Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2015 11:52:07 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:56719 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009330AbbJLJwFmhnwT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Oct 2015 11:52:05 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 601D23C;
        Mon, 12 Oct 2015 02:51:55 -0700 (PDT)
Received: from [10.1.209.125] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 028BC3F59F;
        Mon, 12 Oct 2015 02:51:55 -0700 (PDT)
Message-ID: <561B82BA.30809@arm.com>
Date:   Mon, 12 Oct 2015 10:51:54 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     Alex Smith <alex.smith@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] irqchip: irq-mips-gic: Provide function to map
 GIC user section
References: <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com> <1444642843-16375-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1444642843-16375-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49487
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

On 12/10/15 10:40, Markos Chandras wrote:
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
> [markos.chandras@imgtec.com:
> - Move mapping code to arch/mips/kernel/vdso.c and use a resource
> type to get the GIC usermode information
> - Avoid renaming function arguments and use __gic_base_addr to hold
> the base GIC address prior to ioremap.]
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Changes since v1:
> - Move mapping code to arch/mips/kernel/vdso.c and use a resource
> type to get the GIC usermode information
> - Avoid renaming function arguments and use __gic_base_addr to hold
> the base GIC address prior to ioremap.
> 
> http://www.linux-mips.org/archives/linux-mips/2015-09/msg00316.html
> ---
>  drivers/irqchip/irq-mips-gic.c   | 14 ++++++++++++++
>  include/linux/irqchip/mips-gic.h | 17 +++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index af2f16bb8a94..392beebb81ee 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -29,6 +29,7 @@ struct gic_pcpu_mask {
>  	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
>  };
>  
> +static unsigned long __gic_base_addr;
>  static void __iomem *gic_base;
>  static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
>  static DEFINE_SPINLOCK(gic_lock);
> @@ -301,6 +302,17 @@ int gic_get_c0_fdc_int(void)
>  				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_FDC));
>  }
>  
> +int gic_get_usm_range(struct resource *gic_usm_res)
> +{
> +	if (!gic_present)
> +		return -1;
> +
> +	gic_usm_res->start = __gic_base_addr + USM_VISIBLE_SECTION_OFS;
> +	gic_usm_res->end = gic_usm_res->start + (USM_VISIBLE_SECTION_SIZE - 1);
> +
> +	return 0;
> +}
> +
>  static void gic_handle_shared_int(bool chained)
>  {
>  	unsigned int i, intr, virq, gic_reg_step = mips_cm_is64 ? 8 : 4;
> @@ -790,6 +802,8 @@ static void __init __gic_init(unsigned long gic_base_addr,
>  {
>  	unsigned int gicconfig;
>  
> +	__gic_base_addr = gic_base_addr;
> +
>  	gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
>  
>  	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
> diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
> index 4e6861605050..71ab7c548550 100644
> --- a/include/linux/irqchip/mips-gic.h
> +++ b/include/linux/irqchip/mips-gic.h
> @@ -9,6 +9,7 @@
>  #define __LINUX_IRQCHIP_MIPS_GIC_H
>  
>  #include <linux/clocksource.h>
> +#include <linux/ioport.h>
>  
>  #define GIC_MAX_INTRS			256
>  
> @@ -245,6 +246,8 @@
>  #define GIC_SHARED_TO_HWIRQ(x)	(GIC_SHARED_HWIRQ_BASE + (x))
>  #define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
>  
> +#ifdef CONFIG_MIPS_GIC
> +
>  extern unsigned int gic_present;
>  
>  extern void gic_init(unsigned long gic_base_addr,
> @@ -264,4 +267,18 @@ extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
>  extern int gic_get_c0_compare_int(void);
>  extern int gic_get_c0_perfcount_int(void);
>  extern int gic_get_c0_fdc_int(void);
> +extern int gic_get_usm_range(struct resource *gic_usm_res);
> +
> +#else /* CONFIG_MIPS_GIC */
> +
> +#define gic_present	0
> +
> +static int gic_get_usm_range(struct resource *gic_usm_res)
> +{
> +	/* Shouldn't be called. */
> +	return -1
> +}
> +
> +#endif /* CONFIG_MIPS_GIC */
> +
>  #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
> 

This looks much better than the previous version (though I cannot find
the two other patches on LKML just yet).

FWIW:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
