Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 13:39:10 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37716 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991797AbdHRLi7dwoib (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 13:38:59 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C13E72B;
        Fri, 18 Aug 2017 04:38:52 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48DD3F540;
        Fri, 18 Aug 2017 04:38:51 -0700 (PDT)
Subject: Re: [PATCH 22/38] MIPS: VDSO: Drop gic_get_usm_range() usage
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <20170813043646.25821-23-paul.burton@imgtec.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <7dd8db6f-90b3-84ec-c266-88daaccccbe1@arm.com>
Date:   Fri, 18 Aug 2017 12:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170813043646.25821-23-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59644
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

On 13/08/17 05:36, Paul Burton wrote:
> We don't really need gic_get_usm_range() to abstract discovery of the
> address of the GIC user-visible section now that we have access to its
> base address globally.
> 
> Switch to calculating it ourselves, which will allow us to stop
> requiring the irqchip driver to care about a counter exposed to userland
> for use via the VDSO.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> ---
> 
>  arch/mips/kernel/vdso.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 093517e85a6c..019035d7225c 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -13,13 +13,13 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
> -#include <linux/irqchip/mips-gic.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/timekeeper_internal.h>
>  
>  #include <asm/abi.h>
> +#include <asm/mips-cps.h>
>  #include <asm/vdso.h>
>  
>  /* Kernel-provided data used by the VDSO. */
> @@ -99,9 +99,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  {
>  	struct mips_vdso_image *image = current->thread.abi->vdso;
>  	struct mm_struct *mm = current->mm;
> -	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
> +	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
>  	struct vm_area_struct *vma;
> -	struct resource gic_res;
>  	int ret;
>  
>  	if (down_write_killable(&mm->mmap_sem))
> @@ -125,7 +124,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	 * only map a page even though the total area is 64K, as we only need
>  	 * the counter registers at the start.
>  	 */
> -	gic_size = gic_present ? PAGE_SIZE : 0;
> +	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
>  	vvar_size = gic_size + PAGE_SIZE;
>  	size = vvar_size + image->size;
>  
> @@ -148,13 +147,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  
>  	/* Map GIC user page. */
>  	if (gic_size) {
> -		ret = gic_get_usm_range(&gic_res);
> -		if (ret)
> -			goto out;
> +		gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >> PAGE_SHIFT;

virt_to_pfn() instead?

>  
> -		ret = io_remap_pfn_range(vma, base,
> -					 gic_res.start >> PAGE_SHIFT,
> -					 gic_size,
> +		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
>  					 pgprot_noncached(PAGE_READONLY));
>  		if (ret)
>  			goto out;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
