Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 10:57:19 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:56622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994553AbeIFI5OOZJNA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 10:57:14 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D660ACE1;
        Thu,  6 Sep 2018 08:57:08 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:57:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 23/29] memblock: replace free_bootmem{_node} with
 memblock_free
Message-ID: <20180906085707.GH14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-24-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-24-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Wed 05-09-18 18:59:38, Mike Rapoport wrote:
> The free_bootmem and free_bootmem_node are merely wrappers for
> memblock_free. Replace their usage with a call to memblock_free using the
> following semantic patch:
> 
> @@
> expression e1, e2, e3;
> @@
> (
> - free_bootmem(e1, e2)
> + memblock_free(e1, e2)
> |
> - free_bootmem_node(e1, e2, e3)
> + memblock_free(e2, e3)
> )
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/alpha/kernel/core_irongate.c |  3 +--
>  arch/arm64/mm/init.c              |  2 +-
>  arch/mips/kernel/setup.c          |  2 +-
>  arch/powerpc/kernel/setup_64.c    |  2 +-
>  arch/sparc/kernel/smp_64.c        |  2 +-
>  arch/um/kernel/mem.c              |  3 ++-
>  arch/unicore32/mm/init.c          |  2 +-
>  arch/x86/kernel/setup_percpu.c    |  3 ++-
>  arch/x86/kernel/tce_64.c          |  3 ++-
>  arch/x86/xen/p2m.c                |  3 ++-
>  drivers/macintosh/smu.c           |  2 +-
>  drivers/usb/early/xhci-dbc.c      | 11 ++++++-----
>  drivers/xen/swiotlb-xen.c         |  4 +++-
>  include/linux/bootmem.h           |  4 ----
>  mm/nobootmem.c                    | 30 ------------------------------
>  15 files changed, 24 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
> index f709866..35572be 100644
> --- a/arch/alpha/kernel/core_irongate.c
> +++ b/arch/alpha/kernel/core_irongate.c
> @@ -234,8 +234,7 @@ albacore_init_arch(void)
>  			unsigned long size;
>  
>  			size = initrd_end - initrd_start;
> -			free_bootmem_node(NODE_DATA(0), __pa(initrd_start),
> -					  PAGE_ALIGN(size));
> +			memblock_free(__pa(initrd_start), PAGE_ALIGN(size));
>  			if (!move_initrd(pci_mem))
>  				printk("irongate_init_arch: initrd too big "
>  				       "(%ldK)\ndisabling initrd\n",
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 787e279..e335452 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -538,7 +538,7 @@ static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  	 * memmap array.
>  	 */
>  	if (pg < pgend)
> -		free_bootmem(pg, pgend - pg);
> +		memblock_free(pg, pgend - pg);
>  }
>  
>  /*
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 419dfc42..6d8d0c7 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -561,7 +561,7 @@ static void __init bootmem_init(void)
>  		extern void show_kernel_relocation(const char *level);
>  
>  		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
> -		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
> +		memblock_free(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
>  
>  #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
>  		/*
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 6add560..e564b27 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -765,7 +765,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
>  
>  static void __init pcpu_fc_free(void *ptr, size_t size)
>  {
> -	free_bootmem(__pa(ptr), size);
> +	memblock_free(__pa(ptr), size);
>  }
>  
>  static int pcpu_cpu_distance(unsigned int from, unsigned int to)
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 337febd..a087a6a 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1607,7 +1607,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
>  
>  static void __init pcpu_free_bootmem(void *ptr, size_t size)
>  {
> -	free_bootmem(__pa(ptr), size);
> +	memblock_free(__pa(ptr), size);
>  }
>  
>  static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 185f6bb..3555c13 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -6,6 +6,7 @@
>  #include <linux/stddef.h>
>  #include <linux/module.h>
>  #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>  #include <linux/highmem.h>
>  #include <linux/mm.h>
>  #include <linux/swap.h>
> @@ -46,7 +47,7 @@ void __init mem_init(void)
>  	 */
>  	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
>  	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
> -	free_bootmem(__pa(brk_end), uml_reserved - brk_end);
> +	memblock_free(__pa(brk_end), uml_reserved - brk_end);
>  	uml_reserved = brk_end;
>  
>  	/* this will put all low memory onto the freelists */
> diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
> index 44ccc15..4c572ab 100644
> --- a/arch/unicore32/mm/init.c
> +++ b/arch/unicore32/mm/init.c
> @@ -241,7 +241,7 @@ free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  	 * free the section of the memmap array.
>  	 */
>  	if (pg < pgend)
> -		free_bootmem(pg, pgend - pg);
> +		memblock_free(pg, pgend - pg);
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> index 041663a..a006f1b 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -5,6 +5,7 @@
>  #include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>  #include <linux/percpu.h>
>  #include <linux/kexec.h>
>  #include <linux/crash_dump.h>
> @@ -135,7 +136,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
>  
>  static void __init pcpu_fc_free(void *ptr, size_t size)
>  {
> -	free_bootmem(__pa(ptr), size);
> +	memblock_free(__pa(ptr), size);
>  }
>  
>  static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
> diff --git a/arch/x86/kernel/tce_64.c b/arch/x86/kernel/tce_64.c
> index 54c9b5a..75730ce 100644
> --- a/arch/x86/kernel/tce_64.c
> +++ b/arch/x86/kernel/tce_64.c
> @@ -31,6 +31,7 @@
>  #include <linux/pci.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>  #include <asm/tce.h>
>  #include <asm/calgary.h>
>  #include <asm/proto.h>
> @@ -186,5 +187,5 @@ void __init free_tce_table(void *tbl)
>  	size = table_size_to_number_of_entries(specified_table_size);
>  	size *= TCE_ENTRY_SIZE;
>  
> -	free_bootmem(__pa(tbl), size);
> +	memblock_free(__pa(tbl), size);
>  }
> diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
> index 68c0f14..3cedc0b 100644
> --- a/arch/x86/xen/p2m.c
> +++ b/arch/x86/xen/p2m.c
> @@ -66,6 +66,7 @@
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  
> @@ -188,7 +189,7 @@ static void * __ref alloc_p2m_page(void)
>  static void __ref free_p2m_page(void *p)
>  {
>  	if (unlikely(!slab_is_available())) {
> -		free_bootmem((unsigned long)p, PAGE_SIZE);
> +		memblock_free((unsigned long)p, PAGE_SIZE);
>  		return;
>  	}
>  
> diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> index 332fcca..0069f90 100644
> --- a/drivers/macintosh/smu.c
> +++ b/drivers/macintosh/smu.c
> @@ -569,7 +569,7 @@ int __init smu_init (void)
>  fail_db_node:
>  	of_node_put(smu->db_node);
>  fail_bootmem:
> -	free_bootmem(__pa(smu), sizeof(struct smu_device));
> +	memblock_free(__pa(smu), sizeof(struct smu_device));
>  	smu = NULL;
>  fail_np:
>  	of_node_put(np);
> diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
> index 16df968..4411404 100644
> --- a/drivers/usb/early/xhci-dbc.c
> +++ b/drivers/usb/early/xhci-dbc.c
> @@ -13,6 +13,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/pci_ids.h>
>  #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>  #include <linux/io.h>
>  #include <asm/pci-direct.h>
>  #include <asm/fixmap.h>
> @@ -191,7 +192,7 @@ static void __init xdbc_free_ring(struct xdbc_ring *ring)
>  	if (!seg)
>  		return;
>  
> -	free_bootmem(seg->dma, PAGE_SIZE);
> +	memblock_free(seg->dma, PAGE_SIZE);
>  	ring->segment = NULL;
>  }
>  
> @@ -675,10 +676,10 @@ int __init early_xdbc_setup_hardware(void)
>  		xdbc_free_ring(&xdbc.in_ring);
>  
>  		if (xdbc.table_dma)
> -			free_bootmem(xdbc.table_dma, PAGE_SIZE);
> +			memblock_free(xdbc.table_dma, PAGE_SIZE);
>  
>  		if (xdbc.out_dma)
> -			free_bootmem(xdbc.out_dma, PAGE_SIZE);
> +			memblock_free(xdbc.out_dma, PAGE_SIZE);
>  
>  		xdbc.table_base = NULL;
>  		xdbc.out_buf = NULL;
> @@ -1000,8 +1001,8 @@ static int __init xdbc_init(void)
>  	xdbc_free_ring(&xdbc.evt_ring);
>  	xdbc_free_ring(&xdbc.out_ring);
>  	xdbc_free_ring(&xdbc.in_ring);
> -	free_bootmem(xdbc.table_dma, PAGE_SIZE);
> -	free_bootmem(xdbc.out_dma, PAGE_SIZE);
> +	memblock_free(xdbc.table_dma, PAGE_SIZE);
> +	memblock_free(xdbc.out_dma, PAGE_SIZE);
>  	writel(0, &xdbc.xdbc_reg->control);
>  	early_iounmap(xdbc.xhci_base, xdbc.xhci_length);
>  
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 8d849b4..6c13ff4 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -36,6 +36,7 @@
>  #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
>  
>  #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>  #include <linux/dma-direct.h>
>  #include <linux/export.h>
>  #include <xen/swiotlb-xen.h>
> @@ -248,7 +249,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>  			       xen_io_tlb_nslabs);
>  	if (rc) {
>  		if (early)
> -			free_bootmem(__pa(xen_io_tlb_start), PAGE_ALIGN(bytes));
> +			memblock_free(__pa(xen_io_tlb_start),
> +				      PAGE_ALIGN(bytes));
>  		else {
>  			free_pages((unsigned long)xen_io_tlb_start, order);
>  			xen_io_tlb_start = NULL;
> diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
> index 73f1272..706cf8e 100644
> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -30,10 +30,6 @@ extern unsigned long free_all_bootmem(void);
>  extern void reset_node_managed_pages(pg_data_t *pgdat);
>  extern void reset_all_zones_managed_pages(void);
>  
> -extern void free_bootmem_node(pg_data_t *pgdat,
> -			      unsigned long addr,
> -			      unsigned long size);
> -extern void free_bootmem(unsigned long physaddr, unsigned long size);
>  extern void free_bootmem_late(unsigned long physaddr, unsigned long size);
>  
>  /* We are using top down, so it is safe to use 0 here */
> diff --git a/mm/nobootmem.c b/mm/nobootmem.c
> index bc38e56..85e1822 100644
> --- a/mm/nobootmem.c
> +++ b/mm/nobootmem.c
> @@ -150,33 +150,3 @@ unsigned long __init free_all_bootmem(void)
>  
>  	return pages;
>  }
> -
> -/**
> - * free_bootmem_node - mark a page range as usable
> - * @pgdat: node the range resides on
> - * @physaddr: starting physical address of the range
> - * @size: size of the range in bytes
> - *
> - * Partial pages will be considered reserved and left as they are.
> - *
> - * The range must reside completely on the specified node.
> - */
> -void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
> -			      unsigned long size)
> -{
> -	memblock_free(physaddr, size);
> -}
> -
> -/**
> - * free_bootmem - mark a page range as usable
> - * @addr: starting physical address of the range
> - * @size: size of the range in bytes
> - *
> - * Partial pages will be considered reserved and left as they are.
> - *
> - * The range must be contiguous but may span node boundaries.
> - */
> -void __init free_bootmem(unsigned long addr, unsigned long size)
> -{
> -	memblock_free(addr, size);
> -}
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
