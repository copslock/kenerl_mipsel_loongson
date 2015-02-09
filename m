Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 03:13:49 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:10046 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012916AbbBICNq7MvXE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 03:13:46 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP; 08 Feb 2015 18:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,541,1418112000"; 
   d="scan'208";a="663460808"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2015 18:13:33 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 PGSMSX108.gar.corp.intel.com (10.221.44.103) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Mon, 9 Feb 2015 10:13:31 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.62]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.46]) with mapi id 14.03.0195.001;
 Mon, 9 Feb 2015 10:13:31 +0800
From:   "Wang, Xiaoming" <xiaoming.wang@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "david.vrabel@citrix.com" <david.vrabel@citrix.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@horizon.com" <linux@horizon.com>,
        "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        "Zhang, Dongxing" <dongxing.zhang@intel.com>
Subject: RE: [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
 configurable as flexible requirement about SW-IOMMU.
Thread-Topic: [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
 configurable as flexible requirement about SW-IOMMU.
Thread-Index: AQHQQRJJKhpis9DUDUadJ41Llkm2a5zh7MKAgADSw2CAAKj6gIAEK1Mg
Date:   Mon, 9 Feb 2015 02:13:30 +0000
Message-ID: <FA47D36D6EC9FE4CB463299737C09B9901CFCB18@shsmsx102.ccr.corp.intel.com>
References: <1423177274-22118-1-git-send-email-xiaoming.wang@intel.com>
 <20150205193241.GC11646@x230.dumpdata.com>
 <FA47D36D6EC9FE4CB463299737C09B9901CF8CE6@shsmsx102.ccr.corp.intel.com>
 <20150206181149.GB16455@l.oracle.com>
In-Reply-To: <20150206181149.GB16455@l.oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <xiaoming.wang@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiaoming.wang@intel.com
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

Dear Wilk:

> -----Original Message-----
> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Saturday, February 7, 2015 2:12 AM
> To: Wang, Xiaoming
> Cc: ralf@linux-mips.org; boris.ostrovsky@oracle.com;
> david.vrabel@citrix.com; linux-mips@linux-mips.org; linux-
> kernel@vger.kernel.org; xen-devel@lists.xenproject.org; akpm@linux-
> foundation.org; linux@horizon.com; lauraa@codeaurora.org;
> heiko.carstens@de.ibm.com; d.kasatkin@samsung.com;
> takahiro.akashi@linaro.org; chris@chris-wilson.co.uk; pebolle@tiscali.nl; Liu,
> Chuansheng; Zhang, Dongxing
> Subject: Re: [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
> configurable as flexible requirement about SW-IOMMU.
> 
> On Fri, Feb 06, 2015 at 12:10:15AM +0000, Wang, Xiaoming wrote:
> >
> >
> > > -----Original Message-----
> > > From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> > > Sent: Friday, February 6, 2015 3:33 AM
> > > To: Wang, Xiaoming
> > > Cc: ralf@linux-mips.org; boris.ostrovsky@oracle.com;
> > > david.vrabel@citrix.com; linux-mips@linux-mips.org; linux-
> > > kernel@vger.kernel.org; xen-devel@lists.xenproject.org; akpm@linux-
> > > foundation.org; linux@horizon.com; lauraa@codeaurora.org;
> > > heiko.carstens@de.ibm.com; d.kasatkin@samsung.com;
> > > takahiro.akashi@linaro.org; chris@chris-wilson.co.uk;
> > > pebolle@tiscali.nl; Liu, Chuansheng; Zhang, Dongxing
> > > Subject: Re: [PATCH] modify the IO_TLB_SEGSIZE to io_tlb_segsize
> > > configurable as flexible requirement about SW-IOMMU.
> > >
> > > On Fri, Feb 06, 2015 at 07:01:14AM +0800, xiaomin1 wrote:
> > > > The maximum of SW-IOMMU is limited to 2^11*128 = 256K.
> > > > While in different platform and different requirements this seems
> improper.
> > > > So modify the IO_TLB_SEGSIZE to io_tlb_segsize as configurable is
> > > > make
> > > sense.
> > >
> > > More details please. What is the issue you are hitting?
> > >
> > Example:
> > If 1M bytes are requied. There has an error like.
> 
> Ok, but even with 1MB size - you only have 64 'slots' (if you allocate an 64MB
> buffer). And the other 'slots' can be fragmented so you might still not have
> enough 1MB chunks available.
> 
> Do you have some thoughts on how that would be addressed?
> 
Yes, 
If IO_TLB_SEGSIZE is 128 the slabs is 32K/128 = 256
While IO_TLB_SEGSIZE is 512 the slabs is 32K/512 =64 (for 1M).
So it is dilemma between slabs and segsize.
I have a thought how about modifying the IO_TLB_DEFAULT_SIZE to 
io_tlb_default_size  configurable too?
Because of the multivariate requirement.

> > [   31.474769] dwc3_otg 0000:00:16.0:
> dwc3_intel_byt_notify_charger_type(): dwc3_intel_byt_notify_charger_type:
> invalid SDP current!
> > [   31.554077] android_work: sent uevent USB_STATE=CONNECTED
> > [   31.564244] android_usb gadget: high-speed config #1: android
> > [   31.571468] android_work: sent uevent USB_STATE=CONFIGURED
> > [   31.942738] DMA: Out of SW-IOMMU space for 1048576 bytes at device
> gadget
> > [   31.950345] Kernel panic - not syncing: DMA: Random memory could be
> DMA written
> > [   31.950345]
> > [   31.960170] CPU: 1 PID: 172 Comm: droidboot Tainted: G        W
> 3.10.20-x86_64_byt-g1077f87 #2
> > [   31.970086] Hardware name: Intel Corp. VALLEYVIEW C0
> PLATFORM/BYT-T FFD8, BIOS BLADE_21.X64.0004.R14.1412311144
> FFD8_X64_R_2014_12_31_1151 12/31/2014
> > [   31.985053]  0000000000100000 ffff880136c2fc98 ffffffff82967d45
> ffff880136c2fd10
> > [   31.993327]  ffffffff82961761 0000000000000008 ffff880136c2fd20
> ffff880136c2fcc0
> > [   32.001590]  ffffffff829618fb 0000000000000002 ffffffff820aeff9
> 0000000000008d8c
> > [   32.009871] Call Trace:
> > [   32.012610]  [<ffffffff82967d45>] dump_stack+0x19/0x1b
> > [   32.018353]  [<ffffffff82961761>] panic+0xc8/0x1d6
> > [   32.023707]  [<ffffffff829618fb>] ? printk+0x55/0x57
> > [   32.029258]  [<ffffffff820aeff9>] ? console_unlock+0x1f9/0x460
> > [   32.035772]  [<ffffffff82347cbe>] swiotlb_map_page+0x12e/0x140
> > [   32.042283]  [<ffffffff82599d4d>]
> usb_gadget_map_request+0x16d/0x220
> > [   32.049387]  [<ffffffff8255ce89>] dwc3_gadget_ep_queue+0x229/0x460
> > [   32.056297]  [<ffffffff825b4624>] ffs_epfile_io.isra.96+0x3e4/0x520
> > [   32.063296]  [<ffffffff820e438d>] ? get_parent_ip+0xd/0x50
> > [   32.069427]  [<ffffffff82975a61>] ? sub_preempt_count+0x71/0x100
> > [   32.076142]  [<ffffffff825b47b8>] ffs_epfile_read+0x28/0x30
> > [   32.082370]  [<ffffffff821b6b8c>] vfs_read+0x9c/0x170
> > [   32.088014]  [<ffffffff821b765d>] SyS_read+0x4d/0xa0
> > [   32.093562]  [<ffffffff8297b179>] ia32_do_call+0x13/0x13
> > > >
> > > > Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> > > > Signed-off-by: Zhang Dongxing <dongxing.zhang@intel.com>
> > > > Signed-off-by: xiaomin1 <xiaoming.wang@intel.com>
> > > > ---
> > > >  arch/mips/cavium-octeon/dma-octeon.c |    2 +-
> > > >  arch/mips/netlogic/common/nlm-dma.c  |    2 +-
> > > >  drivers/xen/swiotlb-xen.c            |    6 +++---
> > > >  include/linux/swiotlb.h              |    8 +------
> > > >  lib/swiotlb.c                        |   39 ++++++++++++++++++++++++----------
> > > >  5 files changed, 34 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/arch/mips/cavium-octeon/dma-octeon.c
> > > > b/arch/mips/cavium-octeon/dma-octeon.c
> > > > index 3778655..a521af6 100644
> > > > --- a/arch/mips/cavium-octeon/dma-octeon.c
> > > > +++ b/arch/mips/cavium-octeon/dma-octeon.c
> > > > @@ -312,7 +312,7 @@ void __init plat_swiotlb_setup(void)
> > > >  		swiotlbsize = 64 * (1<<20);
> > > >  #endif
> > > >  	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
> > > > -	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
> > > > +	swiotlb_nslabs = ALIGN(swiotlb_nslabs, io_tlb_segsize);
> > > >  	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
> > > >
> > > >  	octeon_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
> > > > diff --git a/arch/mips/netlogic/common/nlm-dma.c
> > > > b/arch/mips/netlogic/common/nlm-dma.c
> > > > index f3d4ae8..eeffa8f 100644
> > > > --- a/arch/mips/netlogic/common/nlm-dma.c
> > > > +++ b/arch/mips/netlogic/common/nlm-dma.c
> > > > @@ -99,7 +99,7 @@ void __init plat_swiotlb_setup(void)
> > > >
> > > >  	swiotlbsize = 1 << 20; /* 1 MB for now */
> > > >  	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
> > > > -	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
> > > > +	swiotlb_nslabs = ALIGN(swiotlb_nslabs, io_tlb_segsize);
> > > >  	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
> > > >
> > > >  	nlm_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
> > > > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > > > index 810ad41..3b3e9fe 100644
> > > > --- a/drivers/xen/swiotlb-xen.c
> > > > +++ b/drivers/xen/swiotlb-xen.c
> > > > @@ -164,11 +164,11 @@ xen_swiotlb_fixup(void *buf, size_t size,
> > > unsigned long nslabs)
> > > >  	dma_addr_t dma_handle;
> > > >  	phys_addr_t p = virt_to_phys(buf);
> > > >
> > > > -	dma_bits = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT) +
> > > PAGE_SHIFT;
> > > > +	dma_bits = get_order(io_tlb_segsize << IO_TLB_SHIFT) +
> > > > +PAGE_SHIFT;
> > > >
> > > >  	i = 0;
> > > >  	do {
> > > > -		int slabs = min(nslabs - i, (unsigned long)IO_TLB_SEGSIZE);
> > > > +		int slabs = min(nslabs - i, (unsigned long)io_tlb_segsize);
> > > >
> > > >  		do {
> > > >  			rc = xen_create_contiguous_region( @@ -187,7
> > > +187,7 @@ static
> > > > unsigned long xen_set_nslabs(unsigned long nr_tbl)  {
> > > >  	if (!nr_tbl) {
> > > >  		xen_io_tlb_nslabs = (64 * 1024 * 1024 >> IO_TLB_SHIFT);
> > > > -		xen_io_tlb_nslabs = ALIGN(xen_io_tlb_nslabs,
> > > IO_TLB_SEGSIZE);
> > > > +		xen_io_tlb_nslabs = ALIGN(xen_io_tlb_nslabs, io_tlb_segsize);
> > > >  	} else
> > > >  		xen_io_tlb_nslabs = nr_tbl;
> > > >
> > > > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > > > index e7a018e..13506db 100644
> > > > --- a/include/linux/swiotlb.h
> > > > +++ b/include/linux/swiotlb.h
> > > > @@ -8,13 +8,7 @@ struct dma_attrs;  struct scatterlist;
> > > >
> > > >  extern int swiotlb_force;
> > > > -
> > > > -/*
> > > > - * Maximum allowable number of contiguous slabs to map,
> > > > - * must be a power of 2.  What is the appropriate value ?
> > > > - * The complexity of {map,unmap}_single is linearly dependent on
> > > > this
> > > value.
> > > > - */
> > > > -#define IO_TLB_SEGSIZE	128
> > > > +extern int io_tlb_segsize;
> > > >
> > > >  /*
> > > >   * log of the size of each IO TLB slab.  The number of slabs is
> > > > command line diff --git a/lib/swiotlb.c b/lib/swiotlb.c index
> > > > 4abda07..50c415a 100644
> > > > --- a/lib/swiotlb.c
> > > > +++ b/lib/swiotlb.c
> > > > @@ -56,6 +56,15 @@
> > > >  int swiotlb_force;
> > > >
> > > >  /*
> > > > + * Maximum allowable number of contiguous slabs to map,
> > > > + * must be a power of 2.  What is the appropriate value ?
> > > > + * define io_tlb_segsize as a parameter
> > > > + * which can be changed dynamically in config file for special usage.
> > > > + * The complexity of {map,unmap}_single is linearly dependent on
> > > > + this
> > > value.
> > > > + */
> > > > +int io_tlb_segsize = 128;
> > > > +
> > > > +/*
> > > >   * Used to do a quick range check in swiotlb_tbl_unmap_single and
> > > >   * swiotlb_tbl_sync_single_*, to see if the memory was in fact
> > > > allocated by
> > > this
> > > >   * API.
> > > > @@ -97,12 +106,20 @@ static DEFINE_SPINLOCK(io_tlb_lock);  static
> > > > int late_alloc;
> > > >
> > > >  static int __init
> > > > +setup_io_tlb_segsize(char *str)
> > > > +{
> > > > +	get_option(&str, &io_tlb_segsize);
> > > > +	return 0;
> > > > +}
> > > > +__setup("io_tlb_segsize=", setup_io_tlb_segsize);
> > > > +
> > > > +static int __init
> > > >  setup_io_tlb_npages(char *str)
> > > >  {
> > > >  	if (isdigit(*str)) {
> > > >  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
> > > > -		/* avoid tail segment of size < IO_TLB_SEGSIZE */
> > > > -		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > > > +		/* avoid tail segment of size < io_tlb_segsize */
> > > > +		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
> > > >  	}
> > > >  	if (*str == ',')
> > > >  		++str;
> > > > @@ -183,7 +200,7 @@ int __init swiotlb_init_with_tbl(char *tlb,
> > > > unsigned long nslabs, int verbose)
> > > >
> > > >  	/*
> > > >  	 * Allocate and initialize the free list array.  This array is used
> > > > -	 * to find contiguous free memory regions of size up to
> > > IO_TLB_SEGSIZE
> > > > +	 * to find contiguous free memory regions of size up to
> > > > +io_tlb_segsize
> > > >  	 * between io_tlb_start and io_tlb_end.
> > > >  	 */
> > > >  	io_tlb_list = memblock_virt_alloc( @@ -193,7 +210,7 @@ int
> > > > __init swiotlb_init_with_tbl(char *tlb, unsigned
> > > long nslabs, int verbose)
> > > >  				PAGE_ALIGN(io_tlb_nslabs *
> > > sizeof(phys_addr_t)),
> > > >  				PAGE_SIZE);
> > > >  	for (i = 0; i < io_tlb_nslabs; i++) {
> > > > -		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
> > > > +		io_tlb_list[i] = io_tlb_segsize - OFFSET(i, io_tlb_segsize);
> > > >  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> > > >  	}
> > > >  	io_tlb_index = 0;
> > > > @@ -217,7 +234,7 @@ swiotlb_init(int verbose)
> > > >
> > > >  	if (!io_tlb_nslabs) {
> > > >  		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
> > > > -		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > > > +		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
> > > >  	}
> > > >
> > > >  	bytes = io_tlb_nslabs << IO_TLB_SHIFT; @@ -249,7 +266,7 @@
> > > > swiotlb_late_init_with_default_size(size_t default_size)
> > > >
> > > >  	if (!io_tlb_nslabs) {
> > > >  		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
> > > > -		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> > > > +		io_tlb_nslabs = ALIGN(io_tlb_nslabs, io_tlb_segsize);
> > > >  	}
> > > >
> > > >  	/*
> > > > @@ -308,7 +325,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned
> > > > long nslabs)
> > > >
> > > >  	/*
> > > >  	 * Allocate and initialize the free list array.  This array is used
> > > > -	 * to find contiguous free memory regions of size up to
> > > IO_TLB_SEGSIZE
> > > > +	 * to find contiguous free memory regions of size up to
> > > > +io_tlb_segsize
> > > >  	 * between io_tlb_start and io_tlb_end.
> > > >  	 */
> > > >  	io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL, @@ -
> > > 324,7
> > > > +341,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long
> > > > +nslabs)
> > > >  		goto cleanup4;
> > > >
> > > >  	for (i = 0; i < io_tlb_nslabs; i++) {
> > > > -		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
> > > > +		io_tlb_list[i] = io_tlb_segsize - OFFSET(i, io_tlb_segsize);
> > > >  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> > > >  	}
> > > >  	io_tlb_index = 0;
> > > > @@ -493,7 +510,7 @@ phys_addr_t swiotlb_tbl_map_single(struct
> > > > device *hwdev,
> > > >
> > > >  			for (i = index; i < (int) (index + nslots); i++)
> > > >  				io_tlb_list[i] = 0;
> > > > -			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) !=
> > > IO_TLB_SEGSIZE - 1) && io_tlb_list[i]; i--)
> > > > +			for (i = index - 1; (OFFSET(i, io_tlb_segsize) !=
> > > io_tlb_segsize -
> > > > +1) && io_tlb_list[i]; i--)
> > > >  				io_tlb_list[i] = ++count;
> > > >  			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
> > > >
> > > > @@ -571,7 +588,7 @@ void swiotlb_tbl_unmap_single(struct device
> > > *hwdev, phys_addr_t tlb_addr,
> > > >  	 */
> > > >  	spin_lock_irqsave(&io_tlb_lock, flags);
> > > >  	{
> > > > -		count = ((index + nslots) < ALIGN(index + 1, IO_TLB_SEGSIZE) ?
> > > > +		count = ((index + nslots) < ALIGN(index + 1, io_tlb_segsize) ?
> > > >  			 io_tlb_list[index + nslots] : 0);
> > > >  		/*
> > > >  		 * Step 1: return the slots to the free list, merging the @@ -
> > > 585,7
> > > > +602,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev,
> > > phys_addr_t tlb_addr,
> > > >  		 * Step 2: merge the returned slots with the preceding slots,
> > > >  		 * if available (non zero)
> > > >  		 */
> > > > -		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) !=
> > > IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
> > > > +		for (i = index - 1; (OFFSET(i, io_tlb_segsize) !=
> > > > +io_tlb_segsize
> > > > +-1) && io_tlb_list[i]; i--)
> > > >  			io_tlb_list[i] = ++count;
> > > >  	}
> > > >  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> > > > --
> > > > 1.7.9.5
> > > >
