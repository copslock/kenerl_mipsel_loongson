Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2015 23:13:58 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:31434 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012885AbbBPWN4hlrPK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Feb 2015 23:13:56 +0100
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t1GMDUP8004539
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 16 Feb 2015 22:13:31 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
        by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id t1GMDPEk012933
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 16 Feb 2015 22:13:25 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id t1GMDO4C027450;
        Mon, 16 Feb 2015 22:13:24 GMT
Received: from l.oracle.com (/10.137.178.253)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Feb 2015 14:13:24 -0800
Received: by l.oracle.com (Postfix, from userid 1000)
        id AE9536A3C92; Mon, 16 Feb 2015 17:13:22 -0500 (EST)
Date:   Mon, 16 Feb 2015 17:13:22 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Wang Xiaoming <xiaoming.wang@intel.com>
Cc:     ralf@linux-mips.org, boris.ostrovsky@oracle.com,
        david.vrabel@citrix.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        akpm@linux-foundation.org, linux@horizon.com,
        lauraa@codeaurora.org, heiko.carstens@de.ibm.com,
        d.kasatkin@samsung.com, takahiro.akashi@linaro.org,
        chris@chris-wilson.co.uk, pebolle@tiscali.nl,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        Zhang Dongxing <dongxing.zhang@intel.com>
Subject: Re: [PATCH v3] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Message-ID: <20150216221322.GA7442@l.oracle.com>
References: <1424054298-17083-1-git-send-email-xiaoming.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424054298-17083-1-git-send-email-xiaoming.wang@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Source-IP: acsinet21.oracle.com [141.146.126.237]
Return-Path: <konrad.wilk@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Mon, Feb 16, 2015 at 10:38:18AM +0800, Wang Xiaoming wrote:
> The maximum of SW-IOMMU is limited to 2^11*128 = 256K.
> And the maximum of IO_TLB_DEFAULT_SIZE is limited to (64UL<<20) 64M.
> While in different platform and different requirement this seems improper.
> So modifing the IO_TLB_SEGSIZE to io_tlb_segsize and IO_TLB_DEFAULT_SIZE to 
> io_tlb_default_size which can configure by BOARD_KERNEL_CMDLINE in BoardConfig.mk.

Thsi patch does not have anything in BoardConfig.mk. Perhaps remove this.

Got a couple of things below:
> This can meet different requirement.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Zhang Dongxing <dongxing.zhang@intel.com>
> Signed-off-by: Wang Xiaoming <xiaoming.wang@intel.com>
> ---
> patch v1 make this change at Kconfig
> which needs to edit the .config manually.
> https://lkml.org/lkml/2015/1/25/571
> 
> patch v2 only change IO_TLB_SEGSIZE configurable
> https://lkml.org/lkml/2015/2/5/812
> 
>  arch/mips/cavium-octeon/dma-octeon.c |    2 +-
>  arch/mips/netlogic/common/nlm-dma.c  |    2 +-
>  drivers/xen/swiotlb-xen.c            |    6 ++--
>  include/linux/swiotlb.h              |    8 +----
>  lib/swiotlb.c                        |   58 +++++++++++++++++++++++++---------
>  5 files changed, 49 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
> index 3778655..a521af6 100644
> --- a/arch/mips/cavium-octeon/dma-octeon.c
> +++ b/arch/mips/cavium-octeon/dma-octeon.c
> @@ -312,7 +312,7 @@ void __init plat_swiotlb_setup(void)
>  		swiotlbsize = 64 * (1<<20);
>  #endif
>  	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
> -	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
> +	swiotlb_nslabs = ALIGN(swiotlb_nslabs, io_tlb_segsize);
>  	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
>  
>  	octeon_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
> diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
> index f3d4ae8..eeffa8f 100644
> --- a/arch/mips/netlogic/common/nlm-dma.c
> +++ b/arch/mips/netlogic/common/nlm-dma.c
> @@ -99,7 +99,7 @@ void __init plat_swiotlb_setup(void)
>  
>  	swiotlbsize = 1 << 20; /* 1 MB for now */
>  	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
> -	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
> +	swiotlb_nslabs = ALIGN(swiotlb_nslabs, io_tlb_segsize);
>  	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
>  
>  	nlm_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 810ad41..3b3e9fe 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -164,11 +164,11 @@ xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
>  	dma_addr_t dma_handle;
>  	phys_addr_t p = virt_to_phys(buf);
>  
> -	dma_bits = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT) + PAGE_SHIFT;
> +	dma_bits = get_order(io_tlb_segsize << IO_TLB_SHIFT) + PAGE_SHIFT;
>  
>  	i = 0;
>  	do {
> -		int slabs = min(nslabs - i, (unsigned long)IO_TLB_SEGSIZE);
> +		int slabs = min(nslabs - i, (unsigned long)io_tlb_segsize);
>  
>  		do {
>  			rc = xen_create_contiguous_region(
> @@ -187,7 +187,7 @@ static unsigned long xen_set_nslabs(unsigned long nr_tbl)
>  {
>  	if (!nr_tbl) {
>  		xen_io_tlb_nslabs = (64 * 1024 * 1024 >> IO_TLB_SHIFT);
> -		xen_io_tlb_nslabs = ALIGN(xen_io_tlb_nslabs, IO_TLB_SEGSIZE);
> +		xen_io_tlb_nslabs = ALIGN(xen_io_tlb_nslabs, io_tlb_segsize);
>  	} else
>  		xen_io_tlb_nslabs = nr_tbl;
>  
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index e7a018e..13506db 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -8,13 +8,7 @@ struct dma_attrs;
>  struct scatterlist;
>  
>  extern int swiotlb_force;
> -
> -/*
> - * Maximum allowable number of contiguous slabs to map,
> - * must be a power of 2.  What is the appropriate value ?
> - * The complexity of {map,unmap}_single is linearly dependent on this value.
> - */
> -#define IO_TLB_SEGSIZE	128
> +extern int io_tlb_segsize;
>  
>  /*
>   * log of the size of each IO TLB slab.  The number of slabs is command line
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 4abda07..1db5fc8 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -56,6 +56,15 @@
>  int swiotlb_force;
>  
>  /*
> + * Maximum allowable number of contiguous slabs to map,
> + * must be a power of 2.  What is the appropriate value ?
> + * define io_tlb_segsize as a parameter
> + * which can be changed dynamically in config file for special usage.
> + * The complexity of {map,unmap}_single is linearly dependent on this value.
> + */
> +int io_tlb_segsize = 128;
> +
> +/*
>   * Used to do a quick range check in swiotlb_tbl_unmap_single and
>   * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
>   * API.
> @@ -97,12 +106,20 @@ static DEFINE_SPINLOCK(io_tlb_lock);
>  static int late_alloc;
>  
>  static int __init
> +setup_io_tlb_segsize(char *str)
> +{
> +	get_option(&str, &io_tlb_segsize);
> +	return 0;
> +}
> +__setup("io_tlb_segsize=", setup_io_tlb_segsize);

This should be folded in swiotlb=XYZ parsing please. 

Also you will need to update the Documentaiton/kernel-parameters.txt file.

> +
> +static int __init
>  setup_io_tlb_npages(char *str)
>  {
>  	if (isdigit(*str)) {
>  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
> -		/* avoid tail segment of size < IO_TLB_SEGSIZE */
> -		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> +		/* avoid tail segment of size < io_tlb_segsize */
> +		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
>  	}
>  	if (*str == ',')
>  		++str;
> @@ -120,15 +137,26 @@ unsigned long swiotlb_nr_tbl(void)
>  }
>  EXPORT_SYMBOL_GPL(swiotlb_nr_tbl);
>  
> -/* default to 64MB */
> -#define IO_TLB_DEFAULT_SIZE (64UL<<20)
> +/* default to 64MB 
> + * define io_tlb_default_size as a parameter
> + * which can be changed dynamically in config file for special usage.
> + */
> +unsigned long io_tlb_default_size = (64UL<<20);
> +
> +static int __init
> +	setup_io_tlb_default_size(char *str) {
> +	get_option(&str, &io_tlb_default_size);
> +	return 0;
> +}
> +__setup("io_tlb_default_size=", setup_io_tlb_default_size);

Please fold that in swiotlb=XYZ parameter. Make it do all the work.

> +
>  unsigned long swiotlb_size_or_default(void)
>  {
>  	unsigned long size;
>  
>  	size = io_tlb_nslabs << IO_TLB_SHIFT;
>  
> -	return size ? size : (IO_TLB_DEFAULT_SIZE);
> +	return size ? size : (io_tlb_default_size);
>  }
>  
>  /* Note that this doesn't work with highmem page */
> @@ -183,7 +211,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  
>  	/*
>  	 * Allocate and initialize the free list array.  This array is used
> -	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
> +	 * to find contiguous free memory regions of size up to io_tlb_segsize
>  	 * between io_tlb_start and io_tlb_end.
>  	 */
>  	io_tlb_list = memblock_virt_alloc(
> @@ -193,7 +221,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  				PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
>  				PAGE_SIZE);
>  	for (i = 0; i < io_tlb_nslabs; i++) {
> -		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
> +		io_tlb_list[i] = io_tlb_segsize - OFFSET(i, io_tlb_segsize);
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	io_tlb_index = 0;
> @@ -211,13 +239,13 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  void  __init
>  swiotlb_init(int verbose)
>  {
> -	size_t default_size = IO_TLB_DEFAULT_SIZE;
> +	size_t default_size = io_tlb_default_size;
>  	unsigned char *vstart;
>  	unsigned long bytes;
>  
>  	if (!io_tlb_nslabs) {
>  		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
> -		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> +		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
>  	}
>  
>  	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> @@ -249,7 +277,7 @@ swiotlb_late_init_with_default_size(size_t default_size)
>  
>  	if (!io_tlb_nslabs) {
>  		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
> -		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> +		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
>  	}
>  
>  	/*
> @@ -308,7 +336,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  
>  	/*
>  	 * Allocate and initialize the free list array.  This array is used
> -	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
> +	 * to find contiguous free memory regions of size up to io_tlb_segsize
>  	 * between io_tlb_start and io_tlb_end.
>  	 */
>  	io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
> @@ -324,7 +352,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  		goto cleanup4;
>  
>  	for (i = 0; i < io_tlb_nslabs; i++) {
> -		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
> +		io_tlb_list[i] = io_tlb_segsize - OFFSET(i, io_tlb_segsize);
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	io_tlb_index = 0;
> @@ -493,7 +521,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  
>  			for (i = index; i < (int) (index + nslots); i++)
>  				io_tlb_list[i] = 0;
> -			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && io_tlb_list[i]; i--)
> +			for (i = index - 1; (OFFSET(i, io_tlb_segsize) != io_tlb_segsize - 1) && io_tlb_list[i]; i--)
>  				io_tlb_list[i] = ++count;
>  			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
>  
> @@ -571,7 +599,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  	 */
>  	spin_lock_irqsave(&io_tlb_lock, flags);
>  	{
> -		count = ((index + nslots) < ALIGN(index + 1, IO_TLB_SEGSIZE) ?
> +		count = ((index + nslots) < ALIGN(index + 1, io_tlb_segsize) ?
>  			 io_tlb_list[index + nslots] : 0);
>  		/*
>  		 * Step 1: return the slots to the free list, merging the
> @@ -585,7 +613,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  		 * Step 2: merge the returned slots with the preceding slots,
>  		 * if available (non zero)
>  		 */
> -		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
> +		for (i = index - 1; (OFFSET(i, io_tlb_segsize) != io_tlb_segsize -1) && io_tlb_list[i]; i--)
>  			io_tlb_list[i] = ++count;
>  	}
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> -- 
> 1.7.9.5
> 
